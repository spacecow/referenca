class ArticlesController < ApplicationController
  include InitArticleForm

  load_and_authorize_resource
  
  def index
    @articles = Article.search(params[:search],params[:sort]).all. #reference_order
      sort_by_author_first_name_then_year.
      public_or_privately_owned(current_user).
      paginate(:per_page=>25,:page => params[:page])
    @sort = params[:sort]
  end

  def show
    @article = Article.find(params[:id])
    @references = @article.references.
      order('no asc').
      public_or_privately_owned_reference(current_user)
    @references_from = Reference.where(:referenced_article_id => @article.id).
      public_or_privately_owned_referenced(current_user)
  end

  def new
    @article = Article.new
    @keyword = Keyword.new
    init_form(3)
  end

  def create
    @article = Article.new(params[:article])
    @article.owner = current_user
    @article.group = Group.where(:title => current_user.username).first
    if @article.save
      flash[:notice] = "Successfully created article."
      redirect_to @article
    else
      init_form
      render :action => 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
    @keyword = Keyword.new
    init_rendered_form
  end

  def update
    @article = Article.find(params[:id])
    if !@article.pdf.url.nil? && params[:article][:pdf].blank?
      params[:article][:pdf] = @article.pdf
    end
    if @article.update_attributes(params[:article])
      flash[:notice] = "Successfully updated article."
      redirect_to redirect(params[:back], @article)
    else
      unless @article.errors['authorships.author_id'].empty?
        @article.errors['authorships.author_id'][0] =
          @article.authorships.
          map{|e| e.errors.empty? ? nil : Author.find(e.author_id).straight_name}.
          compact.join(', ') + " has already been taken"
      end
      unless @article.errors['articles_keywords.keyword_id'].empty?
        @article.errors['articles_keywords.keyword_id'][0] =
          @article.articles_keywords.
          map{|e| e.errors.empty? ? nil : Keyword.find(e.keyword_id).name}.
          compact.join(', ') + " has already been taken"
      end
      unless @article.errors['references.referenced_article_id'].empty?
        @article.errors['references.referenced_article_id'][0] =
          @article.references.
          map{|e| e.errors.empty? ? nil : Article.find(e.referenced_article_id).reference}.
          compact.join(', ') + " has already been taken"
      end      
      load_articles
      create_empty_reference if @article.errors["references.referenced_article_id"].empty?
      init_form
      render :action => 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = deleted(:article)
    redirect_to articles_url
  end

  def download
    @article = Article.find(params[:id])
    if @article.pdf.url && File.exist?(path = @article.pdf.url)
      send_file path, :content_type => "application/#{@article.extension}",
      :filename => @article.filename
    else
      redirect_to :back, :alert => "File does not exist."
    end
  end

  def update_private_fields
    @article = Article.find(params[:id])
    @article.private  = params[:article][:private]
    @article.pdf      = params[:article][:pdf]
    @article.group_id = params[:article][:group_id]
    if @article.save
      redirect_to @article
    else
      init_rendered_form
      render :edit
    end
  end

  private
    def redirect(option1,option2)
      return option2 if option1.nil?
      option1.empty? ? option2 : option1
    end
end

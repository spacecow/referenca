class ArticlesController < ApplicationController
  include InitArticleForm
  
  def index
    @articles = Article.search(params[:search],params[:sort]).all. #reference_order
      sort_by_author_first_name_then_year.paginate(:per_page=>5,:page => params[:page])
    @sort = params[:sort]
  end

  def show
    @article = Article.find(params[:id])
    @references = @article.references.order('no asc')
    @references_from = Reference.where(:referenced_article_id => @article.id)
  end

  def new
    @article = Article.new
    @keyword = Keyword.new
    init_form(3)
  end

  def create
    @article = Article.new(params[:article])
    @article.author_cache = author_cache(params[:article][:authorships_attributes])
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
    @article.author_cache = author_cache(params[:article][:authorships_attributes])    
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
      load_articles
      create_empty_reference if @article.errors["references.referenced_article_id"].empty?
      init_form
      render :action => 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "Successfully destroyed article."
    redirect_to articles_url
  end

  private

    def author_cache(attributes)
      authors = ""
      attributes.each do |key,value|
        if !value[:author_id].empty? && value[:_destroy] != "1"
          authors += Author.find(value[:author_id]).straight_name+', '
        end
      end
      authors.sub(/, /," (#{@article.year}) ").chop.sub(/,$/,'').gsub(/[,\s]/,'_')
    end
    def redirect(option1,option2)
      return option2 if option1.nil?
      option1.empty? ? option2 : option1
    end
end

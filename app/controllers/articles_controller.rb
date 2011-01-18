class ArticlesController < ApplicationController
  def index
    @articles = Article.search(params[:search],params[:sort]). #reference_order
      sort{|x,y| x.first_author == y.first_author ? y.year <=> x.year : x.first_author <=> y.first_author}.paginate(:per_page=>5,:page => params[:page])
    @sort = params[:sort]
  end

  def show
    @article = Article.find(params[:id])
    @references = @article.references.order('no asc')
    @references_from = Reference.where(:referenced_article_id => @article.id)
  end

  def new
    @article = Article.new
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
    load_articles
    create_empty_reference
    init_form
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
    def create_empty_authorship(no=1); no.times{@article.authorships.build} end
    def create_empty_reference(no=1); no.times{@article.references.build} end
    def init_form(no=1)
      load_author
      load_authors
      create_empty_authorship(no)
    end
    def load_articles
      references = @article.referenced_articles
      @articles = Article.all.
        reject{|e| e==@article}.
#        reject{|e| references.include? e}.
        sort{|x,y| x.first_author == y.first_author ? y.year <=> x.year : x.first_author <=> y.first_author}.
        map{|e| [e.reference, e.id]}
    end
    def load_author; @author = Author.new end
    def load_authors; @authors = Author.order('last_name ASC') end
    def redirect(option1,option2)
      return option2 if option1.nil?
      option1.empty? ? option2 : option1
    end
end

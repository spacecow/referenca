class KeywordsController < ApplicationController
  include InitArticleForm

  def show
    @keyword = Keyword.includes(:articles).find(params[:id])
    @articles = @keyword.articles.sort_by_author_first_name_then_year
  end
  
  def index
    @keywords = Keyword.order('name desc')
  end

  def new
    @keyword = Keyword.new
  end
  
  def create
    @keyword = Keyword.create(params[:keyword])
    id = params[:article_id]
    if @keyword.save
      flash[:notice] = created(:keyword)
      redirect_to new_article_path and return if id == "nil"
      redirect_to edit_article_path Article.find(id.to_i) and return if !id.blank?
      redirect_to keywords_path
    else
      if id == "nil"
        @article = Article.new
        init_rendered_form(3,:keyword)
        render "articles/new"
      elsif !id.blank?
        @article = Article.find(id)
        init_rendered_form(1,:keyword)
        render "articles/edit"
      else
        render "keywords/new"
      end
    end
  end

  def edit
    @keyword = Keyword.find(params[:id])
  end

  def update
    @keyword = Keyword.find(params[:id])
    if @keyword.update_attributes(params[:keyword])
      redirect_to keywords_path, :notice => updated(:keyword)
    else
      render "edit"
    end
  end

  def destroy
    Keyword.find(params[:id]).destroy
    redirect_to keywords_path
  end
end

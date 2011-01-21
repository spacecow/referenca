class AuthorsController < ApplicationController
  include InitArticleForm

  def index
    @authors = Author.all
  end

  def show
    @author = Author.includes({:articles => :authors}).find(params[:id])
    @articles = @author.articles.order("year desc")
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(params[:author])
    id = params[:article_id]
    if @author.save
      flash[:notice] = created(:author)
      redirect_to new_article_path and return if id == "nil"
      redirect_to edit_article_path Article.find(id.to_i) and return unless id.blank?
      redirect_to authors_path
    else
      if id == "nil"
        @article = Article.new
        init_rendered_form(3,:author)
        render 'articles/new'
      elsif !id.blank?
        @article = Article.find(id)
        init_rendered_form(1,:author)
        render 'articles/edit'
      else
        render 'authors/new'
      end
    end
  end

  def edit
    @author = Author.find(params[:id])
  end

  def update
    @author = Author.find(params[:id])
    if @author.update_attributes(params[:author])
      flash[:notice] = "Successfully updated author."
      redirect_to authors_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @author = Author.find(params[:id])
    @author.destroy
    flash[:notice] = "Successfully destroyed author."
    redirect_to authors_url
  end
end

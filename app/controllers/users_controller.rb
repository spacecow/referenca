class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(params[:user])
    if @user.save
      session[:user_id] = @user.id
      @user.groups << Group.new(:title => @user.username)
      redirect_to articles_path, :notice => created(:a_new_user)
    else
      render :new
    end
  end
end

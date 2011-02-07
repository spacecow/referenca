class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(params[:user])
    if @user.save
      session[:user_id] = @user.id
      group = Group.create(:title => @user.username)
      membership = Membership.new(:group_id => group.id, :roles_mask => 1)
      @user.memberships << membership
      redirect_to articles_path, :notice => created(:a_new_user)
    else
      render :new
    end
  end
end

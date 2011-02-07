class GroupsController < ApplicationController
  load_and_authorize_resource

  def show
    @membership = Membership.new
  end
  
  def index
    @memberships = Membership.where('user_id' => current_user.id).includes(:group).order('groups.title asc')
  end

  def new
  end

  def create
    if @group.save
      membership = Membership.create!(:roles_mask => 1, :group_id => @group.id)
      current_user.memberships << membership
      redirect_to groups_path, :notice => created(:group)
    else
      render :new
    end
  end
  
  def edit
  end

  def update
    if @group.update_attributes(params[:group])
      redirect_to @group, :notice => updated(:group)
    else
      render :edit
    end
  end
  
  def destroy
    @group.destroy
    redirect_to groups_path
  end

  def invite_to
    user = User.where(:username => params[:invite]).first || User.where(:email => params[:invite]).first
    @membership = Membership.new
    if user.nil?
      @membership.errors[:user_id] = "User cannot be found."
      render 'groups/show'
    else
      @membership.group_id = @group.id
      @membership.user_id = user.id
      @membership.roles_mask = 2
      if @membership.save
        redirect_to @group
      else
        @membership.errors[:user_id] = "#{params[:invite]} is already a member."
        render 'groups/show'
      end
    end    
  end
end

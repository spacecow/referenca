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
      current_user.groups << @group
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
end

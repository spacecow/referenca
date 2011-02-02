class GroupsController < ApplicationController
  load_and_authorize_resource

  def show
  end
  
  def index
    @memberships = Membership.where('user_id' => current_user.id).includes(:group).order('groups.title asc')
  end

  def new
  end

  def create
    redirect_to @group
  end
  
  def edit    
  end

  def update
    redirect_to @group
  end
  
  def destroy
    @group.destroy
    redirect_to groups_path
  end
end

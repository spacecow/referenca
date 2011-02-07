class MembershipsController < ApplicationController
  load_and_authorize_resource

  def create
    @group = Group.find(params[:group_id])
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

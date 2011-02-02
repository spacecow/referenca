class MembershipsController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    user = User.where(:username => params[:invite]).first || User.where(:email => params[:invite]).first
    if user.nil?
      @membership = Membership.new
      @membership.errors[:user_id] = "User cannot be found."
      render 'groups/show'
    else
      @membership = Membership.create(:user_id => user.id, :group_id => @group.id, :roles_mask => 2)
      if @membership.id.nil?
        @membership.errors[:user_id] = "#{params[:invite]} is already a member."
        render 'groups/show'
      else
        redirect_to @group
      end
    end
  end
end

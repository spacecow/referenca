require 'spec_helper'

def controller_actions(controller)
  Rails.application.routes.routes.inject({}) do |hash, route|
    hash[route.requirements[:action]] = route.verb.downcase if route.requirements[:controller] == controller
    hash
  end
end

describe MembershipsController do
  memberships_controller_actions = controller_actions("memberships")
  login = "http://test.host/login"
  
  before(:each) do
    @group = Factory(:group)
  end

  describe "a user is not logged in" do    
    memberships_controller_actions.each do |action,request|
      it "should not reach the #{action} page" do
        send("#{request}", "#{action}", :group_id => @group.id)
        response.redirect_url.should eq(login)
      end
    end
  end

  describe "a user is logged in" do
    before(:each) do
      @user = Factory(:user)
      session[:user_id] = @user.id      
    end
    
    describe "without membership" do
      memberships_controller_actions.each do |action,request|
        it "should not reach the #{action} page" do
          send("#{request}", "#{action}", :group_id => @group.id)
          response.redirect_url.should eq(login)
        end
      end    
    end

    describe "with normal membership" do
      before(:each) do
        @membership = Factory(:membership, :roles_mask => 2, :group_id => @group.id)
        @user.memberships << @membership
      end

      memberships_controller_actions.each do |action,request|
        it "should not reach the #{action} page" do
          send("#{request}", "#{action}", :group_id => @group.id)
          response.redirect_url.should eq(login)
        end
      end          
    end

    describe "with leader membership" do
      before(:each) do
        @membership = Factory(:membership, :roles_mask => 1, :group_id => @group.id)
        @user.memberships << @membership
      end

      memberships_controller_actions.each do |action,request|
        it "should reach the #{action} page" do
          send("#{request}", "#{action}", :group_id => @group.id)
          response.redirect_url.should_not eq(login)
        end
      end          
    end    
  end
end

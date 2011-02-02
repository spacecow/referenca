require 'spec_helper'

def controller_actions(controller)
  Rails.application.routes.routes.inject({}) do |hash, route|
    hash[route.requirements[:action]] = route.verb.downcase if route.requirements[:controller] == controller
    hash
  end
end

describe GroupsController do
  pages_controller_actions = controller_actions("groups")
  login = "http://test.host/login"
  
  before(:each) do
    @group = Factory(:group)
  end

  describe "a user is not logged in" do    
    pages_controller_actions.each do |action,request|
      it "should not reach the #{action} page" do
        send("#{request}", "#{action}", :id => @group.id)
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
      pages_controller_actions.each do |action,request|
        if %w(index new create).include?(action)
          it "should reach the #{action} page" do
            send("#{request}", "#{action}", :id => @group.id)
            response.redirect_url.should_not eq(login)
          end
        else
          it "should not reach the #{action} page" do
            send("#{request}", "#{action}", :id => @group.id)
            response.redirect_url.should eq(login)
          end
        end
      end    
    end

    describe "with leader membership" do
      before(:each) do
        @membership = Factory(:membership, :roles_mask => 1, :group_id => @group.id)
        @user.memberships << @membership
      end

      pages_controller_actions.each do |action,request|
        it "should reach the #{action} page" do
          send("#{request}", "#{action}", :id => @group.id)
          response.redirect_url.should_not eq(login)
        end
      end          
    end

    describe "with normal membership" do
      before(:each) do
        @membership = Factory(:membership, :roles_mask => 2, :group_id => @group.id)
        @user.memberships << @membership
      end

      pages_controller_actions.each do |action,request|
        if %w(edit update destroy).include?(action)
          it "should not reach the #{action} page" do
            send("#{request}", "#{action}", :id => @group.id)
            response.redirect_url.should eq(login)
          end
        else
          it "should reach the #{action} page" do
            send("#{request}", "#{action}", :id => @group.id)
            response.redirect_url.should_not eq(login)
          end
        end
      end          
    end    
  end
end

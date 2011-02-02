require 'spec_helper'

def controller_actions(controller)
  Rails.application.routes.routes.inject({}) do |hash, route|
    hash[route.requirements[:action]] = route.verb.downcase if route.requirements[:controller] == controller && !route.verb.nil?
    hash
  end
end

describe ArticlesController do
  articles_controller_actions = controller_actions("articles")
  login = "http://test.host/login"

  before(:each) do
    @article = Factory(:article)
  end

  describe "a user is not logged in" do    
    articles_controller_actions.each do |action,request|
      if %w(show index).include?(action)
      else
        it "should not reach the #{action} page" do
          send("#{request}", "#{action}", :id => @article.id)
          response.redirect_url.should eq(login)
        end
      end
    end
  end
  
  describe "author" do
    it "should not be able to appear more than once for an article" do
      author = create_author("Ben","Dover")
      @article.authors << author
      send(:put, :update, :id => @article.id,
           :article => {:authorships_attributes => {"1" => {"author_id" => author.id}}})
      Authorship.count.should eq 1
    end
  end

  describe "a user" do
    before(:each) do
      @user = Factory.create(:user)
      session[:user_id] = @user.id      
    end

    describe "that is not owner or without membership" do
      before(:each) do
        @article = Factory.create(:article)
      end
      it "cannot change private fields" do
        request.env["HTTP_REFERER"] = articles_path
        put(:update_private_fields, :id => @article.id,
            :article => { :private => true })
        Article.find(@article.id).private.should eq false
      end
      it "cannot delete the article" do
        delete(:destroy, :id => @article.id)
        Article.exists?(@article.id).should be_true
      end
    end

    describe "that is owner" do
      before(:each) do
        @article = Factory.create(:article,:owner => @user)
      end
      it "can change private fields" do
        put(:update_private_fields, :id => @article.id,
            :article => { :private => true })
        Article.find(@article.id).private.should eq true
      end
      it "can delete the article" do
        delete(:destroy, :id => @article.id)
        Article.exists?(@article.id).should be_false
      end
    end

    describe "with group membership" do
      before(:each) do
        group = Factory.create(:group)
        @user.groups << group
        @article = Factory.create(:article,:group => group)
      end
      it "can change private fields" do
        put(:update_private_fields, :id => @article.id,
            :article => { :private => true })
        Article.find(@article.id).private.should eq true
      end
      it "can delete the article" do
        delete(:destroy, :id => @article.id)
        Article.exists?(@article.id).should be_false
      end
    end    
  end
  
  describe "reference" do
    it "should not be created if it is blank" do
      send(:put, :update, :id => @article.id,
           :article => referenced_article(""))
      Reference.count.should eq 0
    end

    it "should be created when asked for" do
      reference = Factory.create(:article)
      send(:put, :update, :id => @article.id,
           :article => referenced_article(reference.id))
      Reference.count.should eq 1
    end

    it "should not be able to reference its own article" do
      send(:put, :update, :id => @article.id,
           :article => referenced_article(@article.id))
      Reference.count.should eq 0
    end

    it "should not be able to reference the same article more than once" do
      reference = Factory.create(:article)
      @article.referenced_articles << reference
      send(:put, :update, :id => @article.id,
           :article => referenced_article(reference.id))
      Reference.count.should eq 1
    end
  end
end

def create_author(first_name, last_name)
  Factory.create(:author, :first_name => first_name, :last_name => last_name)
end

def referenced_article(id,no=1)
  {
    :references_attributes => {
      "0"=>{"referenced_article_id" => id, "no" => no}
    }
  }
end

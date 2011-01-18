require 'spec_helper'

describe ArticlesController do
  describe Article do
    before(:each) do
      @article = Factory.create(:article)
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

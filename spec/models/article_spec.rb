require 'spec_helper'

describe Article do
  before(:each) do
    @article = Factory.create(:article, :year => "2001")
    @authors_for_short_reference = :authors_for_short_reference
    @authors_for_long_reference = :authors_for_long_reference    
    @authors_and_year_for_long_reference = :authors_and_year_for_long_reference
    @authors_and_year_for_filename = :authors_and_year_for_filename
  end

  describe "#{@authors_for_long_reference}()" do
    it "should return the authors separated by ','" do
      @article.authors << create_author("Ben","Dover")
      @article.authors << create_author("Shop","Lifter")      
      @article.send(@authors_for_long_reference).should eq "Ben Dover, Shop Lifter"
    end
  end

  describe "#{@authors_and_year_for_long_reference}()" do
    before(:each){ @article.authors << create_author("Ben","Dover") }

    it "should return the year after the author if there's only one" do
      @article.send(@authors_and_year_for_long_reference).should eq "Ben Dover (2001)"
    end

    it "should return the year after the first author if there's more than one" do
      @article.authors << create_author("Shop","Lifter")      
      
      @article.send(@authors_and_year_for_long_reference).should eq "Ben Dover (2001) Shop Lifter"
    end

    it "should return the other authors separated by ',' if there's more than two" do
      @article.authors << create_author("Shop","Lifter")      
      @article.authors << create_author("Bank","Robber")      
      @article.send(@authors_and_year_for_long_reference).should eq "Ben Dover (2001) Shop Lifter, Bank Robber"      
    end
  end

  describe "#{@authors_and_year_for_filename}()" do
    before(:each){ @article.authors << create_author("Ben","Dover") }

    it "should return the year after the author if there's only one" do
      @article.send(@authors_and_year_for_filename).should eq "Ben_Dover_(2001)"
    end

    it "should return the year after the first author if there's more than one" do
      @article.authors << create_author("Shop","Lifter")      
      
      @article.send(@authors_and_year_for_filename).should eq "Ben_Dover_(2001)_Shop_Lifter"
    end

    it "should return the other authors separated by ',' if there's more than two" do
      @article.authors << create_author("Shop","Lifter")      
      @article.authors << create_author("Bank","Robber")      
      @article.send(@authors_and_year_for_filename).should eq "Ben_Dover_(2001)_Shop_Lifter__Bank_Robber"      
    end
  end  
  
  describe "#{@authors_for_short_reference}()" do
    before(:each) do
      @article.authors << create_author("Ben","Dover")
    end
    
    it "should return the author if it is only one" do
      @article.send(@authors_for_short_reference).should eq "Dover"
    end

    it "should return the authors separated with 'and' if they are two" do
      @article.authors << create_author("Shop","Lifter")
      @article.send(@authors_for_short_reference).should eq "Dover and Lifter"
    end

    it "should return the authors separated with 'and' and ',' if they are three" do
      @article.authors << create_author("Shop","Lifter")
      @article.authors << create_author("Repeat","Offender")      
      @article.send(@authors_for_short_reference).should eq "Dover, Lifter and Offender"
    end

    it "should return the first author + et al if they are more than three" do
      @article.authors << create_author("Shop","Lifter")
      @article.authors << create_author("Repeat","Offender")
      @article.authors << create_author("Bank","Robber")      
      @article.send(@authors_for_short_reference).should eq "Dover et al"
    end        
  end
  
end

def create_author(first_name, last_name)
  Factory.create(:author, :first_name => first_name, :last_name => last_name)
end


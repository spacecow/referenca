class Keyword < ActiveRecord::Base
  has_many :articles_keywords, :dependent => :destroy
  has_many :articles, :through => :articles_keywords

  attr_accessible :name
  
  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }
end

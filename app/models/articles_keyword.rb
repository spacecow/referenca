class ArticlesKeyword < ActiveRecord::Base
  belongs_to :article
  belongs_to :keyword

   validates :keyword_id, :presence => true, :uniqueness => {:scope => :article_id}
end

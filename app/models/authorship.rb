class Authorship < ActiveRecord::Base
  belongs_to :author
  belongs_to :article

  validates :author_id, :presence => true, :uniqueness => {:scope => :article_id}
end

class Reference < ActiveRecord::Base
  belongs_to :article
  belongs_to :referenced_article, :class_name => "Article"
  validate :cannot_reference_itself
  validates :referenced_article_id, :presence => true, :uniqueness => {:scope => :article_id}
  validates :article_id, :presence => true
  validates :no, :presence => true, :uniqueness => {:scope => :article_id}
  
  private
    def cannot_reference_itself
      errors.add(:referenced_article_id, "cannot reference itself") if article_id == referenced_article_id
    end  
end

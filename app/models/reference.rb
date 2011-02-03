class Reference < ActiveRecord::Base
  belongs_to :article
  belongs_to :referenced_article, :class_name => "Article"
  validate :cannot_reference_itself
  validates :referenced_article_id, :presence => true, :uniqueness => {:scope => :article_id}
  validates :article_id, :presence => true

  def group_assoc(assoc); send(assoc).group_assoc(assoc) end
  def owner_assoc(assoc); send(assoc).owner_assoc(assoc) end
  def private_assoc(assoc); send(assoc).private_assoc(assoc) end
  
  private
    def cannot_reference_itself
      errors.add(:referenced_article_id, "cannot reference itself") if article_id == referenced_article_id
    end  
end

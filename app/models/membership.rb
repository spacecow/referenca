class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  validates :user_id, :uniqueness => {:scope => :group_id}
  
  before_create :set_role

  ROLES = %w(leader member)

  def role?(role); roles.include? role.to_s end
  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end  
  
  private
  
    def roles=(roles)
      self.roles_mask = (roles & ROLES).map{|r| 2**ROLES.index(r)}.sum
    end
  
    def set_role
      self.roles = ["leader"] if self.roles.empty?
    end  
end

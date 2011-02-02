class Group < ActiveRecord::Base
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  has_many :articles

  attr_accessible :title
  
  validates :title, :uniqueness => true, :presence => true

  def leaders; usernames(leader_memberships) end
  def members; usernames(member_memberships) end

  private
    def leader_memberships; selected_memberships(:leader) end
    def member_memberships; selected_memberships(:member) end
    def selected_memberships(s); memberships.select{|e| e.role? s} end
    def usernames(mships); mships.map{|e| e.user.username}.join(', ') end
end

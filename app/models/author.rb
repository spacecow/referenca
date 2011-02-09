class Author < ActiveRecord::Base
  attr_accessible :first_name, :middle_names, :last_name

  has_many :authorships, :dependent => :destroy
  has_many :articles, :through => :authorships
  
  validates :last_name, :presence => true, :uniqueness => {:scope => [:middle_names, :first_name]}

  def straight_name
    name = first_name
    name += " #{middle_names}" if middle_names?
    name += " #{last_name}"
  end
  
  def reversed_name
    name = "#{last_name}, #{first_name}"
    name += " #{middle_names}" unless middle_names.nil?
    name
  end

#  def to_s; reversed_name end
end

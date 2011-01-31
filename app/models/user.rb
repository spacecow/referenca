class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation

  has_many :memberships, :dependent => :destroy
  has_many :groups, :through => :memberships
  has_many :articles
  
  attr_accessor :password
  before_save :prepare_password

  validates_presence_of :password, :username, :email, :on => :create
  validates_uniqueness_of :username, :email
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true

  # login can be either username or email address
  def self.authenticate(login, pass)
    user = find_by_username(login) || find_by_email(login)
    return user if user && user.matching_password?(pass)
  end

  def matching_password?(pass)
    self.password_hash == encrypt_password(pass)
  end

  private

  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end

  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, password_salt) # add to Gemfile: gem "bcrypt-ruby", :require => "bcrypt"
  end
end

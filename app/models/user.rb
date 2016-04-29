class User < ActiveRecord::Base
  has_secure_password

  has_many :bright_ideas
  has_many :likes, dependent: :destroy
  has_many :bright_ideas, through: :likes, source: :bright_idea

  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :name, :alias, :presence => true
  validates :email, :presence => true, :format => { :with => email_regex }, :uniqueness => { :case_sensitive => false }
  validates :password, :presence => true, :length => {:minimum => 2 }
end

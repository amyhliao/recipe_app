class User < ActiveRecord::Base
  has_many :reviews
  has_many :recipes

  has_secure_password
  validates :username, :email, uniqueness: true, presence: true
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end

class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :token, uniqueness: true
  
  has_many :environments
  has_secure_password
  has_secure_token
end

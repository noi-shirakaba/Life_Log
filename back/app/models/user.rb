class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :token, uniqueness: true
  
  has_many :environments
  has_secure_password
  
  before_create :ensure_token

  private
  
  def ensure_token
    if self.token.blank?
      self.token =
        loop do
          t = SecureRandom.uuid
          break t unless User.where(:token => t).first
        end
    end
  end
end

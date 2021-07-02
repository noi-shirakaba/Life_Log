class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :token, uniqueness: true
  has_many :environments
  has_secure_password
  before_create :ensure_token

  def gwt_token
    payload = { token: token }
    hmac_secret = Rails.application.credentials.read
    # payloadを、hmac_secret(秘密鍵)でHS256アルゴリズムで署名する
    token = JWT.encode(payload, hmac_secret, 'HS256', { typ: 'JWT' })
  end

  def self.auth_gwt_token(token)
    hmac_secret = Rails.application.credentials.read
    decoded_token = JWT.decode(token, hmac_secret, true, { algorithm: 'HS256' })
    self.find_by(token: decoded_token[0]["token"])
  rescue JWT::VerificationError
    nil
  end

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

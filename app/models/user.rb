class User < ActiveRecord::Base

  before_create :create_remember_token

  belongs_to :member

  has_secure_password
  validates :password, length: { minimum: 6 }, :if => :validate_password?  

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  private

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end

  def validate_password?
    password.present? || password_confirmation.present?
  end

end

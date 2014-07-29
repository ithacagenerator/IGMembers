class User < ActiveRecord::Base
  before_save {self.email = email.downcase }
  before_create :create_remember_token

  validates :name, presence: true, length: {maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  belongs_to :membership_type
  has_and_belongs_to_many :discounts
  validates :membership_type, presence: true
  validates :membership_date, presence: true
  
  has_secure_password
  validates :password, length: { minimum: 6 }

  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def cost
    self.membership_type.monthlycost
  end

  private

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end

end

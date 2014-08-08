class User < ActiveRecord::Base
  before_save {self.email = email.downcase }
  before_create :create_remember_token

  validates :name, presence: true, length: {maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  # old, encapsulated method.
#  belongs_to :membership_type
#  has_and_belongs_to_many :discounts
#  validates :membership_type, presence: true
#  validates :membership_date, presence: true

  # new, separate membership method.
  has_many :memberships
  
  has_secure_password
  validates :password, length: { minimum: 6 }, :if => :validate_password?

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

  def current_membership
    active = self.memberships.select { |m| m.member_on?(Date.today())}
    active.first if active.any?
  end

  
  def membership_type
    current_membership.membership_type if current_member?
  end
  
  def cost
    current_membership.cost if current_member?
  end

  def total_discount
    current_membership.total_discount if current_member?
  end

  def current_member?
    !current_membership.nil?
  end

  def member_on?(date)
    memberships.any? { |m| m.member_on?(date) }
  end

  def invoice_for(year,month)
    active_memberships = self.memberships.select { |m| m.invoiceable_on?(year, month)}

    return "Multiple Memberships for #{self.gnucash_id}" if active_memberships.count > 1
    return if !active_memberships.any?

    membership = active_memberships.first()
    membership.invoice_for(year,month)
  end
  
  
  private

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end

  def validate_password?
    password.present? || password_confirmation.present?
  end

end

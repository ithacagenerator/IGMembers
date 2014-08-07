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
    self.current_membership.membership_type unless self.current_membership.nil?
  end
  
  def cost
    self.membership_type.monthlycost
  end

  def total_discount
    #total_fraction = self.discounts.map {|d| d.fraction}.reduce(1,:*)
    #(1 - total_fraction ) * 100
    0 #TODO: refactor discounts out of user
  end
  

  def member_on?(date)
    memberships.any? { |m| m.member_on?(date) }
#    return false if self.membership_date.nil? || date < self.membership_date
#    return true if self.membership_end_date.nil?
#    return false if self.membership_end_date < date
#    return true
  end

  def invoice_for(year,month)
    # GnuCash invoice has 18 fields
    active_memberships = self.memberships.select { |m| m.invoiceable_on?(year, month)}

    return "Multiple Memberships for #{self.gnucash_id}" if active_memberships.count > 1
    return if !active_memberships.any?

    membership = active_memberships.first()
    invoice_date = membership.invoice_date_for(year, month)
  
    id = "#{self.gnucash_id}-#{invoice_date.strftime('%y%m')}" # invoice id
    date_opened = Date.today().to_s()
    owner_id = self.gnucash_id
    billingid = ""
    notes = ""
    date = invoice_date.to_s
    desc = "#{self.membership_type.name} membership for #{date}"
    action = ""
    account = "Income:Membership Dues"
    quantity = "1"
    price = self.cost.to_s()
    disc_type = "%"
    disc_how = ""
    discount = self.total_discount
    taxable = ""
    taxincluded = ""
    tax_table = ""
    date_posted = invoice_date.to_s()
    due_date = (invoice_date + 7).to_s()
    account_posted = ""
    memo_posted = ""
    accu_splits = ""

    [id,date_opened, owner_id, billingid, notes, date,
      desc, action, account, quantity, price, disc_type,
      disc_how, discount, taxable, taxincluded, tax_table, date_posted,
      due_date, account_posted, memo_posted, accu_splits
    ].join(',')
  end
  
  
  private

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end

  def validate_password?
    password.present? || password_confirmation.present?
  end

end

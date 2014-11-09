class Member < ActiveRecord::Base
  before_save {self.email = email.downcase }

  validates :fname, presence: true, length: {maximum: 50 }
  validates :lname, presence: true, length: {maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  has_many :memberships
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :phone, presence: true
  validates_uniqueness_of :gnucash_id, :allow_blank => true, :case_sensitive => true
  validates :gnucash_id, uniqueness: true

  def name
    "#{self.fname} #{self.lname}"
  end

  def current_membership
    active = self.memberships.select { |m| m.member_on?(Date.today())}
    active.first if active.any?
  end

  def membership_end_date
      if current_membership
        current_membership.end_date
      else
        nil
      end
  end

  def membership_date
      if current_membership
        current_membership.start_date
      else
        nil
      end
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

end

class Membership < ActiveRecord::Base
  belongs_to :membership_type
  belongs_to :member
  has_and_belongs_to_many :discounts
  has_and_belongs_to_many :checklist_items

  validates :membership_type, presence: true
  validates :start, presence: true

  def invoice_date_for(year, month)
    Date.new(year, month, self.start.day)
  end

  def invoiceable_on?(year, month)
    member_on?(invoice_date_for(year, month))
  end

  def member_on?(date)
    return false if date < self.start
    return false if !self.end.nil? && date > self.end
    true
  end

  def total_fraction
    discounts.map {|d| d.fraction}.reduce(1,:*)
  end

  def total_discount
    (1 - total_fraction) * 100
  end

  def cost
    membership_type.monthlycost
  end

  def invoice_for(year, month)
    invoice_date = invoice_date_for(year, month)

    # GnuCash invoice has 22 fields

    id = "#{member.gnucash_id}-#{invoice_date.strftime('%y%m')}" # invoice id #
    date_opened = Date.today().to_s()
    owner_id = member.gnucash_id
    billingid = ""
    discount_list = discounts.map{|d| "#{d.percent}% #{d.name}"}.join(' and ' )
    notes = discounts.any? ? "#{discount_list} #{'discount'.pluralize(discounts.count)} applied" : ""
    date = invoice_date.to_s
    desc = "#{self.membership_type.name} membership for #{date}"
    action = ""
    account = "Income:Membership Dues"
    quantity = "1"
    price =  "%.2f" % (cost*total_fraction).round(2)  # self.cost.to_s()
    disc_type = "%"
    disc_how = ""
    discount = "0" # self.total_discount
    taxable = ""
    taxincluded = ""
    tax_table = ""
    date_posted = invoice_date.to_s()
    due_date = (invoice_date + 7).to_s()
    account_posted = "Assets:Accounts Receivable"
    memo_posted = ""
    accu_splits = ""

    [id,date_opened, owner_id, billingid, notes, date,
      desc, action, account, quantity, price, disc_type,
      disc_how, discount, taxable, taxincluded, tax_table, date_posted,
      due_date, account_posted, memo_posted, accu_splits
    ].join(',')
  end

  def enforce_at_most_one_open_membership_for_member
    new_end_date = self.start.prev_day unless self.start.nil?

    if !self.member.nil?
      self.member.memberships.each do |m|
        if m.id != self.id && m.end.nil?
          m.update_attributes(end: new_end_date)
          m.save!
        end
      end
    end
  end

  def member=(the_member)
    self.member_id = the_member.id unless the_member.nil?
    self.enforce_at_most_one_open_membership_for_member
  end
end

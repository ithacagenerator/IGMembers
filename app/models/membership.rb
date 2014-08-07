class Membership < ActiveRecord::Base
  belongs_to :membership_type
  belongs_to :user
  has_and_belongs_to_many :discounts
  
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
  
end

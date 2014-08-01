class Membership < ActiveRecord::Base
  belongs_to :membership_type
  belongs_to :user

  def member_on?(date)
    return false if date < self.start
    return false if !self.end.nil? && date > self.end
    true
  end
  
end

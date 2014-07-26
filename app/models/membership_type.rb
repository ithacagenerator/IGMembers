class MembershipType < ActiveRecord::Base
  validates :name, presence: true
  validates :monthlycost, presence: true
end

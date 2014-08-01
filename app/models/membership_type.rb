class MembershipType < ActiveRecord::Base
  has_many :memberships
  
  validates :name, presence: true
  validates :monthlycost, presence: true
end

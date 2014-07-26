class MembershipType < ActiveRecord::Base
  has_many :users
  
  validates :name, presence: true
  validates :monthlycost, presence: true
end

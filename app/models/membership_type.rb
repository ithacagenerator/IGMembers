class MembershipType < ActiveRecord::Base

  before_destroy :ensure_unused

  has_many :memberships
  
  validates :name, presence: true
  validates :monthlycost, presence: true

  def ensure_unused
    memberships.empty?
  end
end

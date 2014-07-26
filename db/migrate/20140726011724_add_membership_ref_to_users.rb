class AddMembershipRefToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :membership_type, index: true
  end
end

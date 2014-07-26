class AddMembershipDateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :membership_date, :date
  end
end

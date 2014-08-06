class AddMembershipEndDateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :membership_end_date, :date
  end
end

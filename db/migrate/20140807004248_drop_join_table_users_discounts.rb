class DropJoinTableUsersDiscounts < ActiveRecord::Migration
  def change
    drop_join_table :users, :discounts do |t|
      # optional block
    end
  end
end

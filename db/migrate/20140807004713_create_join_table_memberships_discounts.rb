class CreateJoinTableMembershipsDiscounts < ActiveRecord::Migration
  def change
    create_join_table :memberships, :discounts do |t|
      # t.index [:user_id, :discount_id]
      # t.index [:discount_id, :user_id]
    end    
  end
end

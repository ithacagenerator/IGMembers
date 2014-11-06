class RemoveUserIdFromMemberships < ActiveRecord::Migration
  def change
    remove_column :memberships, :user_id, :integer
    add_column :memberships, :member_id, :integer
  end
end

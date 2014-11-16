class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :memberships, :checklist_items do |t|
      # t.index [:membership_id, :checklist_item_id]
      # t.index [:checklist_item_id, :membership_id]
    end
  end
end

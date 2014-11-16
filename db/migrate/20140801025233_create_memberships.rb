class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :membership_type, index: true
      t.references :users, index: true
      t.date :start
      t.date :end

      t.timestamps
    end
  end
end

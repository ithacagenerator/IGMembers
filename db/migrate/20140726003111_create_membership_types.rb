class CreateMembershipTypes < ActiveRecord::Migration
  def change
    create_table :membership_types do |t|
      t.string :name
      t.decimal :monthlycost

      t.timestamps
    end
  end
end

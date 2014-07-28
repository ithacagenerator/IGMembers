class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.string :name
      t.float :percent

      t.timestamps
    end
  end
end

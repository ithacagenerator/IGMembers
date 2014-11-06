class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :lname
      t.string :fname
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end

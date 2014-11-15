class RemoveUnusefulFieldsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :street, :string
    remove_column :users, :name, :string
    remove_column :users, :city, :string
    remove_column :users, :state, :string
    remove_column :users, :zip, :string
    remove_column :users, :membership_type_id, :integer
    remove_column :users, :membership_date, :string
  end
end

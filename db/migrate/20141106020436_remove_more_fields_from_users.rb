class RemoveMoreFieldsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :membership_type_id, :integer
    remove_column :users, :gnucash_id, :string
    remove_column :users, :membership_end_date, :date
  end
end

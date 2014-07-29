class AddGnucashIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :gnucash_id, :string
  end
end

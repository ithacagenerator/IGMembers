class AddGnuCashIdToMembers < ActiveRecord::Migration
  def change
    add_column :members, :gnucash_id, :string
  end
end

class AddMinorFieldsToMember < ActiveRecord::Migration
  def change
    add_column :members, :birthdate, :date
    add_column :members, :parent, :string
  end
end

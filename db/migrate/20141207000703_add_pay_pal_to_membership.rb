class AddPayPalToMembership < ActiveRecord::Migration
  def change
    add_column :memberships, :paypal, :boolean, default: false
  end
end

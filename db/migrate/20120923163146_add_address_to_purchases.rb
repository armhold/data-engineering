class AddAddressToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :address_id, :integer
    add_index  :purchases, :address_id
  end
end

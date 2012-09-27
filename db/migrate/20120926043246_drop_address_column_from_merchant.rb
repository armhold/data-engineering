class DropAddressColumnFromMerchant < ActiveRecord::Migration

  def change
    remove_column :merchants, :address
  end

end

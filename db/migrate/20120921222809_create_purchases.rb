class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.references :customer
      t.references :merchant
      t.references :upload
      t.references :item
      t.integer    :quantity

      t.timestamps
    end
    add_index :purchases, :customer_id
    add_index :purchases, :merchant_id
    add_index :purchases, :upload_id
  end
end

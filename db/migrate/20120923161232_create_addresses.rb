class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.references :merchant

      t.timestamps
    end
    add_index :addresses, :merchant_id
  end
end

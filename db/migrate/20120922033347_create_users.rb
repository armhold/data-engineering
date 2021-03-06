class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :identifier_url

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :identifier_url, unique: true
  end
end

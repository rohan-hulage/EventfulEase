class CreateVendors < ActiveRecord::Migration[7.1]
  def change
    create_table :vendors do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :register_as

      t.timestamps
    end
  end
end

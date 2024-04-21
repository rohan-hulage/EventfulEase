class DropVendorsTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :vendors
  end
end

class AddVendorFieldsToRegistrations < ActiveRecord::Migration[7.1]
  def change
    add_column :registrations, :vendor_type, :string
    add_column :registrations, :expertise, :string
  end
end

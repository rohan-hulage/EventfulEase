class AddVendorIdToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :vendor_id, :integer
  end
end

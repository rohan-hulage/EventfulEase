class UpdateBookingsTable < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookings, :vendor_name, :string
    add_column :bookings, :booking_by, :string
    add_column :bookings, :booking_for, :string
  end
end

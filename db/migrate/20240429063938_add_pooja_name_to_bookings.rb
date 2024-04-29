class AddPoojaNameToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :pooja_name, :string
  end
end

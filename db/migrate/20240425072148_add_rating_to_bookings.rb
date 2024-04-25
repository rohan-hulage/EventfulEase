class AddRatingToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :rating, :integer
  end
end

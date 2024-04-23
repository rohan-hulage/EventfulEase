class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.string :theme
      t.string :vendor_name
      t.integer :price
      t.string :email

      t.timestamps
    end
  end
end

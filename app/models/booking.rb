class Booking < ApplicationRecord
  belongs_to :registration, foreign_key: 'booking_for', primary_key: 'name'
end

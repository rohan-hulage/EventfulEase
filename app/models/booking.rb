class Booking < ApplicationRecord
  belongs_to :registration, foreign_key: 'email', primary_key: 'email'
end

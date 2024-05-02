class Registration < ApplicationRecord

  has_many :bookings, foreign_key: 'email', primary_key: 'email'

  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 25 }, format: { with: VALID_EMAIL_REGEX }

  has_secure_password

  validates_confirmation_of :password

  validates :password, presence: true


end

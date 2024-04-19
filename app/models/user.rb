class User < ApplicationRecord

    before_save { self.email = email.downcase }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 25 }, format: { with: VALID_EMAIL_REGEX }

    has_secure_password

    validates_confirmation_of :password

    validates :password, presence: true
    validate :password_complexity

    private

    def password_complexity
      return if password.blank? || password.length >= 8 && password.match?(/(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/)

      errors.add(:password, "must be at least 8 characters long and include at least one uppercase letter, one lowercase letter, one digit, and one special character")
    end

end

class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates_confirmation_of :password

  def self.authenticate_with_credentials(email, password)
    user = User.find_by('LOWER(email) = ?', email.downcase.strip)

    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end
end
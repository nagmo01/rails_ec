class Payment < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :user_name, uniqueness: true, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :address, presence: true
  validates :pref, presence: true
  validates :city, presence: true
  validates :zip, length: { is: 7 }, presence: true
  validates :cc_name, presence: true
  validates :cc_number, length: { is: 16 }, presence: true
  validates :cc_expiration, length: { is: 4 }, presence: true
  validates :cc_cvv, length: { is: 3 }, presence: true
end

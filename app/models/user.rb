class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :borroweds, dependent: :destroy

  USER_PARAMS = %i(name email sex birth phone address identity_card
    password password_confirmation).freeze
  VALID_EMAIL_REGEX = Settings.valid_email_regex

  validates :name, presence: true, length: {maximum: Settings.maximum_name}
  validates :email, presence: true, length: {maximum: Settings.maximum_email},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: true
  validates :password, presence: true, length: {minimum:
    Settings.minimum_password}
  validates :phone, presence: true, length: {maximum:
    Settings.maximum_phone}
  validates :address, length: {maximum: Settings.maximum_address}
  validates :identity_card, presence: true, length: {maximum:
    Settings.maximum_identity_card}
  enum sex: {male: Settings.enum_active, female: Settings.enum_archived, other: Settings.enum_sold_out}
  enum role: {admin: Settings.enum_active, user: Settings.enum_archived}

  has_secure_password
end

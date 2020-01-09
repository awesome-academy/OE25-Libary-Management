class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  VALID_EMAIL_REGEX = Settings.valid_email_regex
  USER_PARAMS = %i(name email address phone identity_card birth sex password
    password_confirmation remember_me current_password).freeze

  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :borroweds, dependent: :restrict_with_exception
  has_many :books, through: :comments

  before_save :downcase_email

  validates :name, presence: true, length: {maximum: Settings.maximum_name}
  validates :email, presence: true, length: {maximum: Settings.maximum_email},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: true
  validates :password, :current_password, presence: true, length: {minimum:
    Settings.minimum_password}, allow_nil: true
  validates :phone, presence: true, length: {maximum:
    Settings.maximum_phone}
  validates :address, length: {maximum: Settings.maximum_address}
  validates :identity_card, presence: true, length: {maximum:
    Settings.maximum_identity_card}

  enum sex: {male: Settings.enum_active, female: Settings.enum_archived,
             other: Settings.enum_sold_out}
  enum role: {admin: Settings.enum_active, user: Settings.enum_archived}

  scope :order_by_create_at, ->{order created_at: :desc}

  private

  def downcase_email
    email.downcase!
  end
end

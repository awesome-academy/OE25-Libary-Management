class Borrowed < ApplicationRecord
  BORROWED_PARAMS = %i(borrow_day return_day user_id).freeze

  belongs_to :user
  has_many :borrowed_details, dependent: :destroy
  has_many :books, through: :borrowed_details

  validates :borrow_day, :return_day, presence: true, on: :update
  validate :return_day_after_borrow_day, :day_cannot_be_in_the_past, on: :update

  enum status: {pending: 0, borrowed: 1, paid: 2, cancel: 3}

  delegate :name, to: :user, prefix: true
  delegate :book_name, to: :borrowed_details, prefix: true

  scope :borrowed_present_borrow_day, ->{where.not borrow_day: nil}
  scope :order_by_create_at, ->{order created_at: :desc}

  private

  def return_day_after_borrow_day
    return if return_day.blank? || borrow_day.blank?

    return unless return_day < borrow_day

    errors.add :return_day, I18n.t("borrowed_day_fail")
  end

  def day_cannot_be_in_the_past
    return unless borrow_day.present? && borrow_day < Time.zone.today

    errors.add :borrow_day, I18n.t("day_not_past")
  end
end

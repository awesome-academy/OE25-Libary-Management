class Borrowed < ApplicationRecord
  belongs_to :user
  has_many :borrowed_details, dependent: :destroy
  has_many :books, through: :borrowed_details

  validates :borrow_day, :return_day, presence: true, on: :update
  validate :return_day_after_borrow_day, :day_cannot_be_in_the_past, on: :update

  enum status: {pending: 0, borrowed: 1, paid: 2}

  BORROWED_PARAMS = %i(borrow_day return_day user_id).freeze
  delegate :name, to: :books, prefix: true

  private

  def return_day_after_borrow_day
    return if return_day.blank? || borrow_day.blank?

    return unless return_day < borrow_day

    errors.add :return_day, I18n.t("borrowed_day_fail")
  end

  def day_cannot_be_in_the_past
    if borrow_day.present? && borrow_day < Date.today
      errors.add :borrow_day, I18n.t("day_not_past")
    end
  end
end

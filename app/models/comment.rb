class Comment < ApplicationRecord
  COMMENT_PARAMS = %i(content book_id user_id).freeze
  belongs_to :book
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum:
    Settings.maximum_content}

  delegate :name, to: :user, prefix: :user

  scope :order_by_created_at, ->{order created_at: :desc}
end

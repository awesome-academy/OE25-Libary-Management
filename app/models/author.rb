class Author < ApplicationRecord
  extend Excel
  AUTHOR_PARAMS = %i(name description).freeze
  has_many :books, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.max_name_author}
  validates :description, presence: true, length:
    {maximum: Settings.max_description_author}

  scope :order_by_create_at, ->{order created_at: :desc}
end

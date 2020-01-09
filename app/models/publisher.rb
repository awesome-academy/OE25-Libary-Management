class Publisher < ApplicationRecord
  extend Excel
  PUBLISHER_PARAMS = %i(name address).freeze
  has_many :books, dependent: :destroy

  validates :name, presence: true,
    length: {maximum: Settings.max_name_publisher}
  validates :address, length: {maximum: Settings.max_address_publisher}

  scope :order_by_create_at, ->{order created_at: :desc}

end

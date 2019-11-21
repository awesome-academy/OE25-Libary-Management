class Publisher < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true,
    length: {maximum: Settings.max_name_publisher}
  validates :address, length: {maximum: Settings.max_address_publisher}
end

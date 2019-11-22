class Book < ApplicationRecord
  belongs_to :author
  belongs_to :category
  belongs_to :publisher
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.max_name_book }
  validates :price, :amount, :rest_amount, numericality: true
  validates :decription, length: {maximum: Settings.max_decription_book}

  has_one_attached :image
  delegate :name, to: :author, prefix: :author
end

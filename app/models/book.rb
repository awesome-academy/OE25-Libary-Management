class Book < ApplicationRecord
  extend Excel
  BOOK_PARAMS = %i(name author_id category_id publisher_id price rest_amount
    decription image).freeze

  belongs_to :author
  belongs_to :category
  belongs_to :publisher
  has_many :borrowed_details, dependent: :restrict_with_error
  has_many :comments, dependent: :destroy
  has_many :borroweds, through: :borrowed_details,
   dependent: :restrict_with_exception
  has_many :users, through: :comments

  validates :name, presence: true, length: {maximum: Settings.max_name_book}
  validates :price, :rest_amount, numericality: true
  validates :decription, length: {maximum: Settings.max_decription_book}

  has_one_attached :image

  delegate :name, to: :author, prefix: true
  delegate :name, to: :category, prefix: true
  delegate :name, to: :publisher, prefix: true

  ratyrate_rateable "quality"

  scope :order_by_create_at, ->{order created_at: :desc}

  def display_image
    image.variant resize_to_limit: Settings.limit_size_image
  end
end

class Book < ApplicationRecord
  BOOK_PARAMS = %i(name author_id category_id publisher_id price rest_amount
    decription).freeze

  belongs_to :author
  belongs_to :category
  belongs_to :publisher
  has_many :borrowed_detail, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :borroweds, through: :borrowed_detail
  has_many :users, through: :comments

  validates :name, presence: true, length: {maximum: Settings.max_name_book}
  validates :price, :amount, :rest_amount, numericality: true
  validates :decription, length: {maximum: Settings.max_decription_book}

  has_one_attached :image

  delegate :name, to: :author, prefix: true
  delegate :name, to: :category, prefix: true
  delegate :name, to: :publisher, prefix: true

  scope :search, (lambda do |parameter|
                    where("name LIKE :search",
                          search: "%#{parameter}%")
                  end)
end

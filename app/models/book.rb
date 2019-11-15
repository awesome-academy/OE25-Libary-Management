class Book < ApplicationRecord
  belongs_to :author
  belongs_to :category
  belongs_to :publisher
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy
end

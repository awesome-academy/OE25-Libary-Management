class Author < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.max_name_author}
  validates :decription, length: {maximum: Settings.max_decription_author}
end

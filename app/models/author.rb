class Author < ApplicationRecord
  AUTHOR_PARAMS = %i(name description).freeze
  has_many :books, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.max_name_author}
  validates :description, length: {maximum: Settings.max_description_author}
end

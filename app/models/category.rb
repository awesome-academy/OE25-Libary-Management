class Category < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.max_name_category}

  has_ancestry

  scope :load_category_parent, ->{where ancestry: nil}
end

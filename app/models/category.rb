class Category < ApplicationRecord
  has_many :books, dependent: :destroy
  has_many :childrens, class_name: Category.name, foreign_key: :parent_id,
  belongs_to :parent, class_name: Category.name, optional: true
          dependent: :destroy, inverse_of: :parent

  validates :name, presence: true, length: {maximum: Settings.max_name_category}
end

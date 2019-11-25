class Category < ApplicationRecord
  has_many :books, dependent: :destroy
  has_many :childrens, class_name: Category.name, dependent: :destroy,
    foreign_key: :parent_id, inverse_of: :childrens
  belongs_to :parent, class_name: Category.name, optional: true,
    inverse_of: :parent

  validates :name, presence: true, length: {maximum: Settings.max_name_category}
end

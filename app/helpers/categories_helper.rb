module CategoriesHelper
  def category_parent
    Category.load_category_parent
  end
end

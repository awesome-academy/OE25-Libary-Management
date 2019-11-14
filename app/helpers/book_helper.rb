module BookHelper
  def load_category
    Category.pluck :name, :id
  end

  def load_author
    Author.pluck :name, :id
  end
end

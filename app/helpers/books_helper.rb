module BooksHelper
  def load_category
    Category.pluck :name, :id
  end

  def load_author
    Author.pluck :name, :id
  end

  def size_book
    Book.all.size
  end
end

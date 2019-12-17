module BookAction
  extend ActiveSupport::Concern

  def index
    @books = if params[:search].blank?
               Book.includes(:author, :category, :publisher)
             else
               Book.includes(:authors, :categories, :publishers)
                   .search(params[:search].downcase)
             end
    @books = @books.page(params[:page]).per Settings.page_book
  end

  private

  def find_book
    @book = Book.find_by id: params[:id]
    return if @book

    flash[:danger] = t "not_found_book"
    redirect_to root_url
  end
end

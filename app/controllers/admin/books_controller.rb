class Admin::BooksController < AdminController
  include BookAction

  before_action :find_book, only: %i(show edit update destroy)

  def new
    @book = Book.new
  end

  def show; end

  def edit; end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:info] = t "create_book_success"
      redirect_to admin_book_path @book
    else
      flash[:danger] = t "create_book_fail"
      render :new
    end
  end

  def update
    if @book.update book_params
      flash.now[:success] = t "edit_success"
      redirect_to [:admin, @book]
    else
      flash.now[:danger] = t "edit_fail"
      render :edit
    end
  end

  def destroy
    @book.destroy!
    flash[:success] = t "delete_book_success"
  rescue StandardError
    flash[:danger] = t "delete_book_fail"
  ensure
    redirect_to admin_books_url
  end

  private

  def book_params
    params.require(:book).permit Book::BOOK_PARAMS
  end
end

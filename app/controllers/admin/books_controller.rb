class Admin::BooksController < AdminController
  include BookAction

  before_action :find_book, only: %i(show edit update)

  def show; end

  def edit; end

  def update
    if @book.update book_params
      flash.now[:success] = t "edit_success"
      redirect_to [:admin, @book]
    else
      flash.now[:danger] = t "edit_fail"
      render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit Book::BOOK_PARAMS
  end
end

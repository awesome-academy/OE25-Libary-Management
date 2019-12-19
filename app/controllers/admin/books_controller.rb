class Admin::BooksController < AdminController
  include BookAction

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

  def destroy
    begin
      @book.destroy!
      flash[:success] = t "delete_book_success"
    rescue
      flash[:danger] = t "delete_book_fail"
    ensure
      redirect_to admin_books_url
    end
  end

  private

  def book_params
    params.require(:book).permit Book::BOOK_PARAMS
  end
end

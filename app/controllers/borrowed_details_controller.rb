class BorrowedDetailsController < ApplicationController
  before_action :load_book, only: :create

  def create
    if @current_borrowed.books.include? @chosen_book
      find_chosen_book
      @borrowed_detail.quantity += 1
      @borrowed_detail.save
    else
      @current_borrowed.borrowed_details.create book_id: @chosen_book.id
    end

    redirect_to borrowed_path @current_borrowed
  end

  def destroy; end

  private

  def borrow_detail_params
    params.require(:borrow_detail).permit BorrowedDetail::BORROWED_DETAIL_PARAMS
  end

  def load_book
    @chosen_book = Book.find_by id: params[:book_id]
    return if @chosen_book

    flash[:danger] = t "not_found_book"
    redirect_to root_url
  end

  def find_chosen_book
    @borrowed_detail = @current_borrowed.borrowed_details
                                        .find_by book_id: @chosen_book.id
    return if @borrowed_detail

    flash[:danger] = t "not_found_book"
    redirect_to root_url
  end
end

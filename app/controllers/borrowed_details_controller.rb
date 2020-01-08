class BorrowedDetailsController < ApplicationController
  before_action :load_book, only: :create
  before_action :find_borrowed_details, only: :destroy

  def create
    quantity = params[:quantity] || Settings.step_quantity
    if current_borrowed.books.include? @chosen_book
      find_chosen_book
      @borrowed_detail.quantity += quantity.to_i
      save_borrowed_detail
    else
      current_borrowed.borrowed_details.create book_id: @chosen_book.id,
        quantity: quantity
    end

    redirect_to borrowed_path current_borrowed
  end

  def destroy
    if @borrowed_detail.destroy
      respond_to :js
    else
      flash.now[:danger] = t "delete_borrowed_details_fail"
      redirect_to root_url
    end
  end

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
    @borrowed_detail = current_borrowed.borrowed_details
                                       .find_by book_id: @chosen_book.id
    return if @borrowed_detail

    flash[:danger] = t "not_found_book"
    redirect_to root_url
  end

  def save_borrowed_detail
    return flash.now[:success] = t("save_success") if @borrowed_detail.save

    flash.now[:danger] = t "not_save"
    redirect_to root_url
  end

  def find_borrowed_details
    @borrowed_detail = current_borrowed.borrowed_details.find_by id: params[:id]
    return if @borrowed_detail

    flash.now[:danger] = t "not_save"
    redirect_to borrowed_path current_borrowed
  end
end

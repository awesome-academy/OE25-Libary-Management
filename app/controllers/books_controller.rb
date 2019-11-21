class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def show
    @book = Book.find_by id: params[:id]
    return if @book

    flash[:danger] = t "not_found_book"
    redirect_to root_url
  end
end

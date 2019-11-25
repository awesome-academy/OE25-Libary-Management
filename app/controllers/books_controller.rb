class BooksController < ApplicationController
  before_action :find_book, only: :show

  def new
    @book = Book.new
  end

  def show; end

  private

  def find_book
    @book = Book.find_by id: params[:id]
    return if @book

    flash[:danger] = t "not_found_book"
    redirect_to root_url
  end
end

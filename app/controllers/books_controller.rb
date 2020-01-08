class BooksController < ApplicationController
  before_action :find_book, only: :show
  skip_before_action :authenticate_user!

  def index
    @books = if params[:search].blank?
               Book.includes(:author, :category, :publisher)
             else
               Book.includes(:author, :category, :publisher)
                   .search(params[:search].downcase)
             end
    @books = @books.page(params[:page]).per Settings.page_book
  end

  def show
    @comments = @book.comments.includes :user
    @new_comment = @book.comments.build
  end

  private

  def find_book
    @book = Book.find_by id: params[:id]
    return if @book

    flash[:danger] = t "not_found_book"
    redirect_to root_url
  end
end

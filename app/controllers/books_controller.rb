class BooksController < ApplicationController
  before_action :find_book, only: :show
  def index
    if params[:search].blank?
      @books = Book.page(params[:page]).per Settings.page_book
    else
      @books = Book.search(params[:search].downcase)
        .page(params[:page]).per Settings.page_book
    end
  end

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

class StaticPagesController < ApplicationController
  def home
    @books = Book.page(params[:page]).per Settings.page_book
  end
end

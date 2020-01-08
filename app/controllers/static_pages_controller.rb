class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @books = Book.page(params[:page]).per Settings.page_book
  end
end

class BooksController < ApplicationController
  include BookAction

  before_action :find_book, only: %i(show)

  def show
    @comments = @book.comments.includes :user
    @new_comment = @book.comments.build
  end
end

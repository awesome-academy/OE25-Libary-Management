class BooksController < ApplicationController
  include BookAction

  def show
    @comments = @book.comments.includes :user
    @new_comment = @book.comments.build
  end
end

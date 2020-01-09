class CommentsController < ApplicationController
  before_action :load_book, only: :create
  before_action :load_comment, only: :destroy
  load_and_authorize_resource param_method: :comment_params

  def new
    @comment = Comment.new
  end

  def create
    if @comment.save
      @new_comment = @book.comments.build
      respond_to do |format|
        format.html do
          flash[:success] = t "your_comment_has_been_booked"
          redirect_to @book
        end
        format.js
      end
    else
      @new_comment = @comment
      respond_to do |_format|
        render @book
      end
    end
  end

  def destroy
    @book = @comment.book
    if @comment.destroy
      respond_to do |format|
        format.html do
          flash[:success] = t "comment_deleted"
          redirect_to @book
        end
        format.js
      end
    else
      flash[:danger] = t "delete_false"
      redirect_to root_url
    end
  end

  private

  def comment_params
    params.require(:comment).permit Comment::COMMENT_PARAMS
  end

  def load_book
    @book = Book.find_by id: params[:comment][:book_id]
    return if @book

    flash[:danger] = t "not_found_book"
    redirect_to root_url
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
    return if @comment

    flash[:danger] = t "not_found"
    redirect_to root_url
  end
end

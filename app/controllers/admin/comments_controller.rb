class Admin::CommentsController < AdminController
  before_action :load_comment, only: :destroy

  def index
    @comment = Comment.ransack params[:q]
    @comments = @comment.result.order_by_create_at
                        .page(params[:page]).per Settings.page_user
  end

  def destroy
    if @comment.destroy
      respond_to do |format|
        format.html do
          flash[:success] = t "comment_deleted"
          redirect_to admin_comments_path
        end
        format.js
      end
    else
      flash[:danger] = t "delete_false"
      redirect_to root_url
    end
  end

  private

  def load_comment
    @comment = Comment.find_by id: params[:id]
    return if @comment

    flash[:danger] = t "not_found"
    redirect_to root_url
  end
end

class Admin::AuthorsController < AdminController
  before_action :load_author, only: %i(show destroy)

  def show; end

  def index
    @authors = Author.page(params[:page]).per Settings.page_book
  end

  def destroy
    if @author.destroy
      respond_to do |format|
        format.html do
          flash[:success] = t "author_deleted"
          redirect_to admin_authors_path
        end
        format.js
      end
    else
      respond_to do |format|
        format.js{render "alert(#{t('delete_borrowed_details_fail')});"}
      end
    end
  end

  private

  def load_author
    return if @author = Author.find_by(id: params[:id])

    flash[:danger] = t "not_found"
    redirect_to root_url
  end
end

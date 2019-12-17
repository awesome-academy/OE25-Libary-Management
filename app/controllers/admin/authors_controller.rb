class Admin::AuthorsController < AdminController
  before_action :load_author, only: :show

  def show; end

  def index
    @authors = Author.page(params[:page]).per Settings.page_book
  end

  private

  def load_author
    return if @author = Author.find_by(id: params[:id])

    flash[:danger] = t "not_found"
    redirect_to root_url
  end
end

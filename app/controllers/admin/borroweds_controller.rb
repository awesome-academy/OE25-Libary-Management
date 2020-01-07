class Admin::BorrowedsController < AdminController
  before_action :find_borrowed, only: %i(show update)

  def index
    @borroweds = Borrowed.includes(:borrowed_details, :user)
                         .page(params[:page]).per Settings.page_borrowed
  end

  def show
    @borrowed_details = @borrowed
                        .borrowed_details
                        .includes(book: [:image_attachment, :image_blob])
  end

  def update
    if @borrowed.update status: params[:status]
      flash[:success] = t "update_success"
    else
      flash[:danger] = t "update_fail"
    end
    redirect_to admin_borrowed_path @borrowed
  end

  private

  def find_borrowed
    return if @borrowed = Borrowed.find_by(id: params[:id])

    flash[:danger] = t "not_found_borrowed"
    redirect_to root_url
  end
end

class Admin::BorrowedsController < AdminController
  include BorrowedsHelper

  before_action :find_borrowed, only: %i(show update)
  load_and_authorize_resource

  def index
    @borrowed = Borrowed.ransack params[:q]
    @borroweds = @borrowed.result.order_by_create_at
                          .page(params[:page]).per Settings.page_user
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

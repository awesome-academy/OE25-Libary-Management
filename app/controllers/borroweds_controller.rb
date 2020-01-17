class BorrowedsController < ApplicationController
  before_action :find_borrowed, only: %i(edit update destroy)
  load_and_authorize_resource

  def index
    @borroweds = current_user.borroweds.includes(:borrowed_details)
                             .page(params[:page]).per Settings.page_borrowed
  end

  def show
    @borrowed_details = current_borrowed
                        .borrowed_details
                        .includes(book: [:image_attachment, :image_blob])
  end

  def edit; end

  def update
    if @borrowed.update borrow_params
      flash[:success] = t "borrow_success"
      session.delete(:borrowed_id)
      redirect_to borroweds_path
    else
      render :edit
    end
  end

  def destroy
    if @borrowed.destroy
      respond_to :js
    else
      respond_to do |format|
        format.js{render "alert(#{t('delete_book_fail')});"}
      end
    end
  end

  private

  def find_borrowed
    return if @borrowed = Borrowed.find_by(id: params[:id])

    flash.now[:danger] = t "not_found_borrowed"
    redirect_to root_url
  end

  def borrow_params
    params.require(:borrowed).permit Borrowed::BORROWED_PARAMS
  end
end

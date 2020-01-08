class Admin::PublishersController < AdminController
  include PublishersHelper

  before_action :load_publisher, except: %i(index create new)
  before_action :search_publisher, only: :index

  def show; end

  def new
    @publisher = Publisher.new
  end

  def index
    respond_to do |format|
      format.html
      format.xls{send_data Author.to_csv(col_sep: "\t")}
    end
  end

  def create
    @publisher = Publisher.new publisher_params
    if @publisher.save
      flash[:success] = t "create_success"
      redirect_to admin_publishers_path
    else
      flash[:danger] = t "create_false"
      render :new
    end
  end

  def edit; end

  def update
    if @publisher.update publisher_params
      flash[:success] = t "publisher_update"
      redirect_to admin_publisher_path
    else
      flash[:danger] = t "publisher_false"
      render :edit
    end
  end

  def destroy
    if @publisher.destroy
      respond_to do |format|
        format.html do
          flash[:success] = t "publisher_deleted"
          redirect_to admin_publishers_path
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

  def publisher_params
    params.require(:publisher).permit Publisher::PUBLISHER_PARAMS
  end

  def load_publisher
    return if @publisher = Publisher.find_by(id: params[:id])

    flash[:danger] = t "not_found"
    redirect_to root_url
  end

  def search_publisher
    @publishers = Publisher.page(params[:page]).per Settings.page_book
    return if params[:search].blank?

    @publishers = Publisher.search(params[:search].downcase)
                           .page(params[:page]).per Settings.page_book
  end
end

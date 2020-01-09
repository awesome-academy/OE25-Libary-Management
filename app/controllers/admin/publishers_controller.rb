class Admin::PublishersController < AdminController
  before_action :load_publisher, except: %i(index create new)

  def show; end

  def new
    @publisher = Publisher.new
  end

  def index
    @publisher = Publisher.ransack params[:q]
    @publishers = @publisher.result.order_by_create_at
                            .page(params[:page]).per Settings.page_user
    respond_to do |format|
      format.html
      format.xls do
        send_data Publisher.to_csv(column_names: [:id, :name],
       col_sep: "\t")
      end
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
end

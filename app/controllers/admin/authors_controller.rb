class Admin::AuthorsController < AdminController
  include AuthorsHelper
  before_action :load_author, except: %i(index new create)

  def show; end

  def new
    @author = Author.new
  end

  def index
    @author = Author.ransack params[:q]
    @authors = @author.result.order_by_create_at
                      .page(params[:page]).per Settings.page_user
    respond_to do |format|
      format.html
      format.xls do
        send_data Author.to_csv(column_names: [:id, :name],
       col_sep: "\t")
      end
    end
  end

  def create
    @author = Author.new author_params
    if @author.save
      flash[:success] = t "success"
      redirect_to admin_authors_path
    else
      flash[:danger] = t "create_false"
      render :new
    end
  end

  def edit; end

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

  def update
    if @author.update author_params
      flash[:success] = t "author_update"
      redirect_to admin_author_path
    else
      flash[:danger] = t "update_false"
      render :edit
    end
  end

  private

  def author_params
    params.require(:author).permit Author::AUTHOR_PARAMS
  end

  def load_author
    @author = Author.find_by(id: params[:id])
    return if @author

    flash[:danger] = t "not_found"
    redirect_to root_url
  end
end

class Admin::AuthorsController < AdminController
  before_action :load_author, except: %i(index create new)

  def show; end

  def new
    @author = Author.new
  end

  def edit; end

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

  def update
    if @author.update author_params
      flash[:success] = t "author_update"
      redirect_to admin_author_path
    else
      flash[:danger] = t "update_false"
      render :edit
    end
  end

  def create
    @author = Author.new author_params
    if @author.save
      flash[:success] = t "create_success"
      redirect_to admin_authors_path
    else
      flash[:danger] = t "create_false"
      render :new
    end
  end

  private

  def author_params
    params.require(:author).permit Author::AUTHOR_PARAMS
  end

  def load_author
    return if @author = Author.find_by(id: params[:id])

    flash[:danger] = t "not_found"
    redirect_to root_url
  end
end

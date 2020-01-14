class Admin::BooksController < AdminController
  include BooksHelper

  before_action :find_book, except: %i(new index create)

  def show; end

  def new
    @book = Book.new
  end

  def index
    @book = Book.ransack params[:q]
    @books = @book.result.order_by_create_at
                  .page(params[:page]).per Settings.page_user
    respond_to do |format|
      format.html
      format.xls do
        send_data Book.to_csv(column_names: [:id, :name],
       col_sep: "\t")
      end
    end
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:info] = t "create_book_success"
      redirect_to admin_book_path @book
    else
      flash[:danger] = t "create_book_fail"
      render :new
    end
  end

  def edit; end

  def update
    if @book.update book_params
      flash.now[:success] = t "edit_success"
      redirect_to [:admin, @book]
    else
      flash.now[:danger] = t "edit_fail"
      render :edit
    end
  end

  def destroy
    begin
      @book.destroy!
      flash[:success] = t "delete_book_success"
    rescue StandardError
      flash[:danger] = t "delete_book_fail"
    ensure
      redirect_to admin_books_url
    end
  end

  private

  def book_params
    params.require(:book).permit Book::BOOK_PARAMS
  end

  def find_book
    @book = Book.find_by id: params[:id]
    return if @book

    flash[:danger] = t "not_found_book"
    redirect_to root_url
  end
end

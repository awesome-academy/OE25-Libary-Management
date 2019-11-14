module BorrowedsHelper
  def current_borrowed
    set_borrowed if user_signed_in?
    @borrowed
  end

  def borrowed_present
    borroweds = current_user.borroweds
    borroweds.borrowed_present_borrow_day.page(params[:page])
             .per Settings.page_borrowed
  end

  def set_borrowed
    return if @borrowed = current_user.borroweds
                                      .find_by(id: session[:borrowed_id])

    @borrowed = current_user.borroweds.create
    session[:borrowed_id] = @borrowed.id
  end

  def size_borrowed
    Borrowed.all.size
  end
end

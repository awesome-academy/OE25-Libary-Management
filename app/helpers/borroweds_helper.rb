module BorrowedsHelper
  def current_borrowed
    set_borrowed if logged_in?
    @borrowed
  end

  def borroweds_present_day
    current_user.borroweds.select {|borrowed| borrowed.borrow_day.present? }
  end

  private

  def set_borrowed
    return if @borrowed = current_user.borroweds.find_by(id: session[:borrowed_id])

    @borrowed = current_user.borroweds.create
    session[:borrowed_id] = @borrowed.id
  end

end

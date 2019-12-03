module BorrowedsHelper
  def current_borrowed
    if logged_in?
      if session[:borrowed_id]
        borrowed = current_user.borroweds.find_by id: session[:borrowed_id]
        if borrowed.blank?
          borrowed = current_user.borroweds.create
          session[:borrowed_id] = borrowed.id
        end
      else
        borrowed = current_user.borroweds.create
        session[:borrowed_id] = borrowed.id
      end
    end
    borrowed
  end
end

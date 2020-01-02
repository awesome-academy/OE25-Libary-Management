module SpecTestHelper
  def logged_in user
    request.session[:user_id] = user.id
  end
end

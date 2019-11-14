class AdminController < ApplicationController
  layout "admin_application"

  def dashboard
    render "static_pages/dashboard"
  end
end

class AdminController < ApplicationController
  load_and_authorize_resource :admin

  layout "admin_application"

  def dashboard
    render "static_pages/dashboard"
  end
end

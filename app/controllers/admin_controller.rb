class AdminController < ApplicationController
  include SessionsHelper

  layout "admin_application"

  def dashboard
    render "static_pages/dashboard"
  end
end

class AdminController < ApplicationController
  include SessionsHelper

  before_action :check_admin

  layout "admin_application"

  def dashboard
    render "static_pages/dashboard"
  end

  def check_admin
    return if current_user.admin?

    flash[:danger] = t "not_admin"
    redirect_to root_path
  end
end

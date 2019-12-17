class SessionsController < ApplicationController
  before_action :check_user_present, only: :create

  def new; end

  def create
    if @user.authenticate(params[:session][:password])
      log_in @user
      flash[:success] = t "welcome"
      if params[:session][:remember_me] == Settings.remember_me
        remember @user
      else
        forget @user
      end
      check_role_user
    else
      flash.now[:danger] = t "email_password"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def check_user_present
    @user = User.find_by email: params[:session][:email].downcase
    return if @user&.activated?

    flash[:danger] = t "email_password"
    render :new
  end

  def check_role_user
    if @user.admin?
      redirect_to(admin_dashboard_path)
    else
      redirect_back_or root_url
    end
  end
end

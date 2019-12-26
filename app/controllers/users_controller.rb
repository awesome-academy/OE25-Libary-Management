class UsersController < ApplicationController
  before_action :load_user, :logged_in_user, only: %i(show edit update)
  before_action :correct_user, only: %i(show edit update)

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "please_check"
      redirect_to root_url
    else
      flash[:danger] = t "create_false"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "profile_update"
      redirect_to @user
    else
      flash[:danger] = t "update_false"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def correct_user
    redirect_to(root_url) unless current_user? @user
  end

  def load_user
    return if @user = User.find_by(id: params[:id])

    flash[:danger] = t "not_found"
    redirect_to root_url
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "please_log_in"
    redirect_to login_url
  end
end

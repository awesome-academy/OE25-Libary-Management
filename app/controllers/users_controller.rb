class UsersController < ApplicationController
  before_action :load_user, only: :show

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:info] = t "please_check"
      redirect_to root_url
    else
      flash[:danger] = t "create_false"
      render :new
    end
  end

  def show; end

  private

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "not_found"
    redirect_to root_url
  end
end

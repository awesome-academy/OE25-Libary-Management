class UsersController < ApplicationController
  before_action :load_user

  def show; end

  private

  def load_user
    return if @user = User.find_by(id: params[:id])

    flash[:danger] = t "not_found"
    redirect_to root_url
  end
end

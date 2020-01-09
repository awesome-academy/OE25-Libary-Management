class ApplicationController < ActionController::Base
  include BorrowedsHelper

  before_action :set_locale, :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :ransack

  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = exception.message
    redirect_to root_url
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: User::USER_PARAMS
    devise_parameter_sanitizer.permit :account_update, keys: User::USER_PARAMS
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def ransack
    @q = Book.ransack params[:q]
  end
end

class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :set_locale, :current_borrowed

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def current_borrowed
    if session[:borrowed_id]
      borrowed = Borrowed.find_by id: session[:borrowed_id]
      if borrowed.present?
        @current_borrowed = borrowed
      else
        @current_borrowed = Borrowed.create
        session[:borrowed_id] = @current_borrowed.id
      end
    else
      @current_borrowed = Borrowed.create
      session[:borrowed_id] = @current_borrowed.id
    end
  end
end

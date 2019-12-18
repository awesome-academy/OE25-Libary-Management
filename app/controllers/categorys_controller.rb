class CategorysController < ApplicationController
  before_action :load_category, only: :show

  def show; end

  def index
    @categories = Category.page(params[:page]).per Settings.page_book
  end

  private

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category

    flash[:danger] = t "not_found"
    redirect_to root_url
  end
end

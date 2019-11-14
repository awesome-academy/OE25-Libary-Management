class CategoriesController < ApplicationController
  skip_load_and_authorize_resource
  before_action :find_category, only: :show

  def show
    @books = @category.books
  end

  private

  def find_category
    @category = Category.find_by id: params[:id]
    return if @category

    flash[:danger] = t "category_fail"
    redirect_to root_url
  end
end

class Admin::CategoriesController < AdminController
  load_and_authorize_resource

  def index; end
end

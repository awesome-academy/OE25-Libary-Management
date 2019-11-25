class BorrowedsController < ApplicationController
  def show
    @borrowed_details = @current_borrowed.borrowed_details
  end

  def destroy; end
end

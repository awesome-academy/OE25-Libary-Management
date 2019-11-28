class BorrowedsController < ApplicationController
  def show
    @borrowed_details = @current_borrowed
                        .borrowed_details
                        .includes(book: [:image_attachment, :image_blob])
  end

  def destroy; end
end

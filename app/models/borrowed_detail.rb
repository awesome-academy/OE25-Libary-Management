class BorrowedDetail < ApplicationRecord
  belongs_to :borrowed
  belongs_to :book

  BORROWED_DETAIL_PARAMS = %i(book_id borrowed_id quantity).freeze
end

class BorrowedDetail < ApplicationRecord
  belongs_to :borrowed
  belongs_to :book
end

class Borrowed < ApplicationRecord
  belongs_to :user, optional: true
  has_many :borrowed_details, dependent: :destroy
  has_many :books, through: :borrowed_details
end

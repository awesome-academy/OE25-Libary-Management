class Borrowed < ApplicationRecord
  belongs_to :user
  has_many :borrowed_details, dependent: :destroy
end

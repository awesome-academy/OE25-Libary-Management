class Publisher < ApplicationRecord
  PUBLISHER_PARAMS = %i(name address).freeze
  has_many :books, dependent: :destroy

  validates :name, presence: true,
    length: {maximum: Settings.max_name_publisher}
  validates :address, length: {maximum: Settings.max_address_publisher}

  scope :search, (lambda do |parameter|
                    where("name LIKE :search",
                          search: "%#{parameter}%")
                  end)

  class << self
    def to_csv options = {}
      CSV.generate(options) do |csv|
        csv << [:id, :name]
        all.find_each do |publisher|
          csv << publisher.attributes.values_at("id", "name")
        end
      end
    end
  end
end

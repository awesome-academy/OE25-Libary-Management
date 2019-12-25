class Author < ApplicationRecord
  AUTHOR_PARAMS = %i(name description).freeze
  has_many :books, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.max_name_author}
  validates :description, presence: true, length:
    {maximum: Settings.max_description_author}

  scope :search, (lambda do |parameter|
                    where("name LIKE :search",
                          search: "%#{parameter}%")
                  end)

  class << self
    def to_csv options = {}
      CSV.generate(options) do |csv|
        csv << [:id, :name]
        all.find_each do |author|
          csv << author.attributes.values_at("id", "name")
        end
      end
    end
  end
end

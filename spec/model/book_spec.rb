require "rails_helper"

RSpec.describe Book, type: :model do
  let!(:author){FactoryBot.create :author}
  let!(:publisher){FactoryBot.create :publisher}
  let!(:category){FactoryBot.create :category}
  subject {FactoryBot.build :book, author_id: author.id, publisher_id: publisher.id, category_id: category.id }

  describe "Valid book" do
    it {expect(subject).to be_valid}
    it {expect(subject.image).to be_attached}
  end

  describe "Validates" do
    it {expect(subject).to validate_presence_of(:name).with_message(I18n.t("error_blank"))}
    it {expect(subject).to validate_length_of(:name).with_message(I18n.t("error_too_long_length"))}
    it {expect(subject).to validate_numericality_of(:price).with_message(I18n.t("error_not_numericality"))}
    it {expect(subject).to validate_numericality_of(:amount).with_message(I18n.t("error_not_numericality"))}
    it {expect(subject).to validate_numericality_of(:rest_amount).with_message(I18n.t("error_not_numericality"))}
    it {expect(subject).to validate_length_of(:decription).with_message(I18n.t("error_too_long_length"))}
  end

  describe "Associations" do
    it {expect(subject).to belong_to :author}
    it {expect(subject).to belong_to :category}
    it {expect(subject).to belong_to :publisher}
  end

  describe "Scopes" do
    let!(:author){FactoryBot.create :author}
    let!(:publisher){FactoryBot.create :publisher}
    let!(:category){FactoryBot.create :category}
    let!(:book1){FactoryBot.create :book, name: "love shot"}

    context "Search by name" do
      it {expect(Book.search("h")).to eq [book1]}
    end
  end
end

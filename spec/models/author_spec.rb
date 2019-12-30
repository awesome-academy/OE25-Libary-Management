require "rails_helper"

RSpec.describe Author, type: :model do
  subject {FactoryBot.build :author}

  describe "Valid author" do
    it {expect(subject).to be_valid}
  end

  describe "Associations" do
    it {expect(subject).to have_many :books}
  end

  describe "Validations" do
    it {expect(subject).to validate_presence_of(:name).with_message(I18n.t("error_blank"))}
    it {expect(subject).to validate_length_of(:name).with_message(I18n.t("errors_length_name"))}
    it {expect(subject).to validate_presence_of(:description).with_message(I18n.t("error_blank"))}
    it {expect(subject).to validate_length_of(:description).with_message(I18n.t("errors_length_description"))}
  end

  describe "Scopes" do
    let!(:au1){FactoryBot.create :author, name: "Author1"}

    context "Search with result" do
      it {expect(Author.search("au")).to include au1}
    end

    context "Search blank" do
      it {expect(Author.search(" ")).not_to include au1}
    end

    context "Search whithout result" do
      it {expect(Author.search("mi")).not_to include au1}
    end
  end
end

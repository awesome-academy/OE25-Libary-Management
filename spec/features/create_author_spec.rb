require "rails_helper"

RSpec.feature "Create Author", type: :feature do
  let!(:user){FactoryBot.create :user, role: Settings.enum_admin}

  before do
    visit login_path
    fill_in "session[email]", :with => user.email
    fill_in "session[password]", :with => user.password
    click_button "login_rspec"
    visit "/en/admin/authors/new"
  end

  feature "create success" do
    scenario "Admin creates a new author" do
      fill_in "author[name]", with: "author"
      fill_in "author[description]", with: "Hello"
      click_button "commit"
      expect(page).to have_text I18n.t("success")
      expect(page).to have_current_path("/en/admin/authors")
    end
  end

  feature "create success" do
    scenario "missing name" do
      fill_in "author[description]", with: "Hello"
      click_button "commit"
      expect(page).to have_text I18n.t("error_blank")
    end

    scenario "missing description" do
      fill_in "author[name]", with: "Author"
      click_button "commit"
      expect(page).to have_text I18n.t("error_blank")
    end

    scenario "name too long" do
      fill_in "author[name]", with: Faker::Lorem.characters(number: Settings.name_long)
      fill_in "author[description]", with: "Hello"
      click_button "commit"
      expect(page).to have_text I18n.t("create_false")
    end

    scenario " description too long" do
      fill_in "author[name]", with: "author"
      fill_in "author[description]", with: Faker::Lorem.characters(number: Settings.decription_long)
      click_button "commit"
      expect(page).to have_text I18n.t("create_false")
    end
  end
end

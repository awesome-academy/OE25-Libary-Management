require "rails_helper"

RSpec.feature "Login", type: :feature do
  let!(:user) {FactoryBot.create :user}
  let!(:admin) {FactoryBot.create :user, role: Settings.role_admin}

  before do
    visit login_path
  end

  feature "Login success" do
    scenario "role: user" do
      fill_in "session[email]", with: user.email
      fill_in "session[password]", with: user.password
      within ".form-login" do
        click_button "commit"
      end
      expect(page).to have_current_path("/en")
    end

    scenario "role: admin" do
      fill_in "session[email]", with: admin.email
      fill_in "session[password]", with: admin.password
      within ".form-login" do
        click_button "commit"
      end
      expect(page).to have_current_path("/en")
    end
  end

  feature "Invalid input" do
    scenario "missing email" do
      fill_in "session[password]", with: user.password
      within ".form-login" do
        click_button "commit"
      end
      expect(page).to have_text I18n.t "email_password"
      expect(page).to have_current_path("/en/login")
    end

    scenario "missing password" do
      fill_in "session[email]", with: user.email
      within ".form-login" do
        click_button "commit"
      end
      expect(page).to have_text I18n.t "email_password"
      expect(page).to have_current_path("/en/login")
    end

    scenario "missing both field" do
      within ".form-login" do
        click_button "commit"
      end
      expect(page).to have_text I18n.t "email_password"
      expect(page).to have_current_path("/en/login")
    end
  end

  feature "Login failed" do
    scenario "wrong email & password" do
      fill_in "session[email]", with: Settings.fake_email
      fill_in "session[password]", with: "123123"
      within ".form-login" do
        click_button "commit"
      end
      expect(page).to have_text I18n.t "email_password"
      expect(page).to have_current_path("/en/login")
    end
  end
end

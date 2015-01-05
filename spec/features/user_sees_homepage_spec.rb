require "rails_helper"

feature "visits homepage", %q{
  As a guest, I want to visit the homepage and see a list of top rated places
  to work, so that I can decide where to work today.

  Acceptance Criteria:
  - [ ] I see the title of the website
  - [ ] I see a list inspiration
  } do

    scenario "visits homepage" do
      user = FactoryGirl.create(:user)
      visit new_user_session_path

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_button "Log in"

      visit root_path

      expect(page).to have_content(user.username)
    end
  end

require "rails_helper"

feature "user sees account details", %Q{
  As a user, I want to view my account page,
  So I can see my account & make any changes

  Acceptance Criteria:
  -[ ] I see my username,email, and can change my password
  -[ ] I see a link to edit my information
  } do

  scenario "visit your account detail and edit" do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"

    visit edit_user_registration_path(user)
    fill_in "Username", with: "change"
    fill_in "Current password", with: user.password
    click_on "Update"

    expect(page).to have_content "Your account has been updated successfully"
    expect(page).to have_content "Hello change"
    expect(page).to have_content "What keeps you going?"
  end

  scenario "user tries to edit account user is signed out" do
    visit edit_user_registration_path
    expect(page).to have_content
    "You need to sign in or sign up before continuing."
  end

end

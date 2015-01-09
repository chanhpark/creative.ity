require "rails_helper"

feature "user creates Post", %{
  As a user
  I want to be able to create a post to show
  So that I can share it with others
  } do

  scenario "if signed in" do

    user = FactoryGirl.create(:user)
    post = FactoryGirl.create(:post)

    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect(page).to have_content("Signed in successfully")
    expect(page).to have_content("Add Creative.ity")

    click_on "Add Creative.ity"

    fill_in "Title", with: post.title
    fill_in "Link", with: post.link
    fill_in "Description", with: post.description

    click_on "Create Post"

      expect(page).to have_content post.title
      expect(page).to have_content post.description
      expect(page).to have_content "Hit or Miss"


  end
  scenario "site is not created successfully" do
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    click_on "Add Creative.ity"

    click_button "Create Post"
    expect(page).to have_content "Titlecan't be blank"
    expect(page).to have_content "Linkcan't be blank"

  end

  scenario "user sees create site" do

    user = FactoryGirl.create(:user)
    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: "password"

    click_button "Log in"

    visit posts_path

    expect(page).to have_content "Add Creative.ity"
  end
end

require "rails_helper"

feature "user updates post", %{
  As an authenticated user
  I want to update a post information
  So that I can correct errors or provide new information
  } do

    scenario "authenticated user sees edit button on show page" do
      FactoryGirl.create(:post, title: "rando")
      edit_post = FactoryGirl.create(:post)
      visit new_user_session_path

      fill_in "Email", with: edit_post.user.email
      fill_in "Password", with: "password"

      click_button "Log in"

      visit post_path(edit_post)
      expect(page).to have_content(:link_or_button, "Edit")
      expect(page).to have_content("rando")

    end

    scenario "unauthenticated user does not see edit button on show page" do
      FactoryGirl.create(:post, title: "rando")
      edit_post = FactoryGirl.create(:post)

      visit post_path(edit_post)

      expect(page).to_not have_content(:link_or_button, "Edit")

    end

    scenario "authenticated user edits post" do
      FactoryGirl.create(:post, title: "rando")
      edit_post = FactoryGirl.create(:post)

      visit new_user_session_path

      fill_in "Email", with: edit_post.user.email
      fill_in "Password", with: "password"

      click_button "Log in"

      visit edit_post_path(edit_post)
      fill_in "Title", with: "pierce"

      click_button "Update Post"
      expect(page).to have_content "Successfully updated your post"
      expect(page).to have_content "pierce"

    end
    scenario "authenticated user unsuccessfully edits post" do
      FactoryGirl.create(:post, title: "rando")
      edit_post = FactoryGirl.create(:post)
      visit new_user_session_path

      fill_in "Email", with: edit_post.user.email
      fill_in "Password", with: "password"

      click_button "Log in"

      visit edit_post_path(edit_post)
      fill_in "Title", with: ""

      click_button "Update Post"
      expect(page).to have_content "Titlecan't be blank"
    end
  end

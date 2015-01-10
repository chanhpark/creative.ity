require "rails_helper"

feature "user adds comment", %{
  As a user, I want to be able to rate posts
  and optionally provide a comment
  So others can see those details.

  Acceptance Criteria:
  -[ ] I must give a rating and optionally a review comment
  -[ ] I must see those on the post page
  -[ ] I must be signed in to Create Comment
  -[ ] The post maker must receive an email saying a new review has been posted
  } do

    let (:test_post) do
      FactoryGirl.create(:post)
      FactoryGirl.create(:post, title: "MERP!")
    end

    scenario "Visits a post" do

      visit post_path(test_post)

      expect(page).to have_content "Reply to thread"
    end

    scenario "Create Comment" do
      user = FactoryGirl.create(:user)

      visit new_user_session_path

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_button "Log in"

      expect(page).to have_content("Signed in successfully")
      expect(page).to have_content("Log out")

      visit post_path(test_post)
      fill_in "Reply to thread", with: "awesome!"
      click_on "Create Comment"

      expect(page).to have_content "Successfully added your comment"
    end
    scenario "user tries to add multiple comments to a post" do
      user = FactoryGirl.create(:user)

      visit new_user_session_path

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_button "Log in"

      visit post_path(test_post)

      fill_in "Reply to thread", with: "awesome YES!"
      click_on "Create Comment"
      fill_in "Reply to thread", with: "awesome!"
      click_on "Create Comment"

      expect(page).to have_content "You have already commented on this post"

    end

    scenario "User tries to add comment as a Guest" do

      visit post_path(test_post)
      click_on "Create Comment"

      expect(page).to have_content "You need to sign in
      or sign up before continuing."
    end
    scenario "user tries to edit comments to a post with blank" do
      user = FactoryGirl.create(:user)

      visit new_user_session_path

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_button "Log in"

      visit post_path(test_post)

      fill_in "Reply to thread", with: "awesome YES!"
      click_on "Create Comment"
      click_on "Edit Comment"
      fill_in "Reply to thread", with: ""
      click_on "Update Comment"

      expect(page).to have_content "can't be blank"
    end
    scenario "user tries comment blank to post" do
      user = FactoryGirl.create(:user)

      visit new_user_session_path

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_button "Log in"

      visit post_path(test_post)

      fill_in "Reply to thread", with: ""
      click_on "Create Comment"

      expect(page).to have_content "You cant post a blank comment"
    end
  end

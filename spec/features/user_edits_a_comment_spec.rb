require "rails_helper"

feature "User updates a comment that they created", %{
  As a user,
  I want to be able to update a comment,
  So it can change my comment.

  Acceptance Criteria:
  [ ] I must own the comment I am trying to edit.
  [ ] When a comment is updated successfully, I see a success message
  [ ] When I am unsuccessful, I se an error message

  } do
    let :post do
      FactoryGirl.create(:post)
      FactoryGirl.create(:post, title: "High Endurance")
    end

    scenario "User updates a comment they own" do
      user = FactoryGirl.create(:user)

      visit new_user_session_path

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_button "Log in"

      visit post_path(post)
      fill_in "Reply to thread", with: "awesome!"
      click_on "Create Comment"

      expect(page).to have_content "Edit Comment"

      click_on "Edit Comment"

      fill_in "Reply to thread", with: "the spirit of the wolf"

      click_button "Update Comment"

      expect(page).to have_content "Comment Updated Successfully"
      expect(page).to have_content "the spirit of the wolf"
    end
    scenario "User Should not be able to update a comment they dont own" do
      user = FactoryGirl.create(:user)

      visit new_user_session_path

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_button "Log in"

      visit post_path(post)
      fill_in "Reply to thread", with: "awesome!"
      click_on "Create Comment"

      click_on "Log out"

      visit post_path(post)

      expect(page).to_not have_content "Edit Comment"
    end
  end

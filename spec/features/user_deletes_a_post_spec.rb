require "rails_helper"

feature "User Deletes A Site", %{
  As a user,
  I want to delete a site that I created,
  So that I can remove old sites.

  Acceptance Criteria:

  [ ] If i don"t own the site, I should not see a delete button on the site page
  [ ] If I own the site, i should see a delete button on the site page
  [ ] I should not see the site"s information on the index page anymore
  } do

    let(:post) do
      FactoryGirl.create(:post)
      FactoryGirl.create(:post, title: "LOL")
    end

    scenario "logged in user deletes a site they created" do
      sign_in_as(post.user)

      visit post_path(post)

      click_on "Delete"

      expect(current_path) == posts_path
      expect(page).to_not have_content post.title
    end

    scenario "non logged in user should not see delete button" do
      visit post_path(post)

      expect(page).to_not have_content(:link_or_button, "Delete")
    end

  end

require "rails_helper"

feature "sees the details of a post", %{
  As a guest, I want to view the details of a post, so that
  I can decide if it meets my criteria for a work post
  } do

    let (:test_post) do
      FactoryGirl.create(:post)
      FactoryGirl.create(:post, title: "YEAH")
    end

    scenario "sees the name of the post" do
      visit post_path(test_post)

      expect(page).to have_content test_post.title
    end

    scenario "sees the location of the post" do
      visit post_path(test_post)

      expect(page).to have_content test_post.title
      expect(page).to have_link "Visit Link"
      expect(page).to have_content test_post.description
    end
  end

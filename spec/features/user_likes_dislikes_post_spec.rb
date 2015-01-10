require "rails_helper"

feature "votes on post", %{
  As an authenticated user I want to vote on a post.
  I can only vote once per comment
  Each comment has a total number of votes.

  Acceptance Criteria:

  [ ] User is authenticated
  [ ] User votes on a post
  [ ] User can change their vote
  [ ] post has a total number of votes
  [ ] Users can only vote once per comment


  } do

    let(:user) do
      FactoryGirl.create(:user)
    end

    let (:post) do
      FactoryGirl.create(:post)
      FactoryGirl.create(:post, title: "TIGERS!")
    end

    scenario "User can like a post " do
      sign_in_as(post.user)

      visit post_path(post)
      click_link("Like")

      expect(page).to have_content post.get_upvotes.size
    end

    scenario "User can dislike a post" do
      sign_in_as(post.user)

      visit post_path(post)
      click_link("Dislike")

      expect(page).to have_content post.get_downvotes.size
      save_and_open_page
    end

    scenario "User can change vote" do
      sign_in_as(post.user)

      visit post_path(post)
      click_link("Like")
      click_link("Dislike")

      expect(page).to have_content post.get_downvotes.size
      expect(page).to have_content "You Disliked this post"
    end

    scenario "User can only vote once per comment" do
      sign_in_as(post.user)

      visit post_path(post)
      click_link("Like")
      click_link("Dislike")
      click_link("Dislike")

      expect(page).to have_content post.get_downvotes.size
      expect(page).to have_content "You Disliked this post"
    end
  end

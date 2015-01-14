require "rails_helper"

feature "search posts" do
  scenario "fill in search form and view results" do
    post1 = FactoryGirl.create(:post, title: "my creativeity")
    post2 = FactoryGirl.create(:post, title: "creativeity is going bananas")
    FactoryGirl.create(:post, title: "its okay")

    visit posts_path
    fill_in "query", with: "creativeity"
    click_button "Search"

    expect(page).to have_link("my creativeity", href: post_path(post1))
    expect(page).to have_link("creativeity is going bananas", href: post_path(post2))
    expect(page).to_not have_content("its okay")
  end

  scenario "fill in blank search" do
    visit posts_path
    fill_in "query", with: "nothing"
    click_button "Search"

    expect(page).to have_content("No results found")
  end

end

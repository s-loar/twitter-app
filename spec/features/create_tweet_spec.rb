require 'rails_helper'

RSpec.feature "Creating Tweets" do
  scenario "A user creates a new tweet" do
    visit "/"
    click_link "New Tweet"
    fill_in "Body", with: "Lorem Ipsum"
    click_button "Tweet"

    expect(page).to have_content("Tweet has been posted")
    expect(page.current_path).to eq(tweets_path)
  end
end
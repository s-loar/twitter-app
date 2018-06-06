require 'rails_helper'

RSpec.feature "Delete a Tweet" do
  before do
    @tweet = Tweet.create(body: "First Tweet")
  end

  scenario "User deletes a tweet" do
    visit "/"
    click_link @tweet.body
    click_link "Delete Tweet"

    expect(page).to have_content("Tweet has been deleted")
    expect(page.current_path).to eq(tweets_path)
  end

end
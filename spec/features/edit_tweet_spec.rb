require 'rails_helper'

RSpec.feature "Edit Tweet" do
  before do
    @tweet = Tweet.create(body: "First Tweet")
  end

  scenario "User edits a tweet" do
    visit "/"
    click_link @tweet.body
    click_link "Edit Tweet"
    fill_in "Body", with: "Updated tweet"
    click_button "Post"

    expect(page).to have_content("Tweet has been updated")
    expect(page.current_path).to eq(tweet_path(@tweet))
  end

  scenario "User fails to edit a tweet" do
    visit "/"
    click_link @tweet.body
    click_link "Edit Tweet"
    fill_in "Body", with: ""
    click_button "Post"

    expect(page).to have_content("Tweet has not been updated")
    expect(page.current_path).to eq(tweet_path(@tweet))
  end
end

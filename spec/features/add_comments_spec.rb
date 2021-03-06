require 'rails_helper'

RSpec.feature "Add Comments to Tweets" do

  before do
    @jake = User.create!(email: "jake@example.com", password: "password", name: "Jake")
    @sally = User.create!(email: "sally@example.com", password: "password", name: "Sally")
    @tweet = Tweet.create(body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", user: @jake)
    @sally.follow(@jake)
  end

  scenario "permits a signed in user to make a comment" do
    login_as(@sally)
    visit '/'
    click_link @tweet.body
    fill_in "New Comment", with: "Great tweet!"
    click_button "Add Comment"

    expect(page).to have_content("Comment has been added")
    expect(page).to have_content("Great tweet")
    expect(current_path).to eq(tweet_path(@tweet.id))
  end
end
require 'rails_helper'

RSpec.feature "Show a Tweet" do

  before do
    @jake = User.create!(email: "jake@example.com", password: "password", name: "Jake")
    @sally = User.create!(email: "sally@example.com", password: "password", name: "Sally")
    @tweet = Tweet.create(body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", user: @jake)
    @sally.follow(@jake)
  end

  scenario "hide the tweet from a not signed in user" do
    visit '/'
    expect(page).not_to have_link(@tweet.body)
  end

  scenario "hide the edit and delete from a signed in, non-owner user" do
    login_as(@sally)
    visit '/'
    click_link @tweet.body

    expect(page).to have_content(@tweet.body)
    expect(page.current_path).to eq(tweet_path(@tweet))
    expect(page).not_to have_link("Edit Tweet")
    expect(page).not_to have_link("Delete Tweet")
  end

  scenario "show the edit and delete to a signed in, owner user" do
    login_as(@jake)
    visit '/'
    click_link @tweet.body

    expect(page).to have_content(@tweet.body)
    expect(page.current_path).to eq(tweet_path(@tweet))
    expect(page).to have_link("Edit Tweet")
    expect(page).to have_link("Delete Tweet")
  end
end
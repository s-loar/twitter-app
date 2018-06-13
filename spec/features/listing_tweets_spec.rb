require 'rails_helper'

RSpec.feature "List Tweets" do
  before do
    @jake = User.create!(email: "jake@example.com", password: "password", name: "Jake")
    @sally = User.create!(email: "sally@example.com", password: "password", name: "Sally")
    @tweet3 = Tweet.create(body: "Third Tweet", user: @jake)
    @tweet4 = Tweet.create(body: "Fourth Tweet", user: @jake)
    @tweet1 = Tweet.create(body: "First Tweet", user: @jake)
    @tweet2 = Tweet.create(body: "Second Tweet", user: @jake)
    @tweet6 = Tweet.create(body: "Sally Tweet", user: @sally)
  end

  scenario "User lists all tweets and is signed in" do
    login_as(@jake)
    visit "/"

    expect(page).to have_content(@tweet1.body)
    expect(page).to have_link(@tweet1.body)
    expect(page).to have_content(@tweet2.body)
    expect(page).to have_link(@tweet2.body)

    expect(page).to have_link("New Tweet")
    expect(page).to have_link("2")
  end

  scenario "User lists all tweets and is signed in but no pagination" do
    login_as(@sally)
    visit "/"

    expect(page).to have_content(@tweet6.body)
    expect(page).to have_link(@tweet6.body)
    expect(page).not_to have_content(@tweet1.body)
    expect(page).not_to have_link(@tweet1.body)

    expect(page).to have_link("New Tweet")
    expect(page).not_to have_link("2")
  end

  scenario "User lists all tweets and is not signed in" do
    visit "/"

    expect(page).not_to have_content(@tweet1.body)
    expect(page).not_to have_link(@tweet1.body)
    expect(page).not_to have_content(@tweet2.body)
    expect(page).not_to have_link(@tweet2.body)
    expect(page).not_to have_link("New Tweet")
    within("h1#no-tweets") do
      expect(page).to have_content("No Tweets in Your Feed")
    end
  end

  scenario "No tweets to list" do
    Tweet.delete_all
    visit "/"

    expect(page).not_to have_content(@tweet1.body)
    expect(page).not_to have_link(@tweet1.body)
    expect(page).not_to have_content(@tweet2.body)
    expect(page).not_to have_link(@tweet2.body)

    within("h1#no-tweets") do
      expect(page).to have_content("No Tweets in Your Feed")
    end
  end
end

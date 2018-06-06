require 'rails_helper'

RSpec.feature "List Tweets" do
  before do
    @jake = User.create!(email: "jake@example.com", password: "password")
    @tweet1 = Tweet.create(body: "First Tweet", user: @jake)
    @tweet2 = Tweet.create(body: "Second Tweet", user: @jake)
  end

  scenario "User lists all tweets" do
    visit "/"

    expect(page).to have_content(@tweet1.body)
    expect(page).to have_link(@tweet1.body)
    expect(page).to have_content(@tweet2.body)
    expect(page).to have_link(@tweet2.body)
  end

  scenario "No tweets to list" do
    Tweet.delete_all
    visit "/"

    expect(page).not_to have_content(@tweet1.body)
    expect(page).not_to have_link(@tweet1.body)
    expect(page).not_to have_content(@tweet2.body)
    expect(page).not_to have_link(@tweet2.body)

    within("h1#no-tweets") do
      expect(page).to have_content("No Tweets Posted")
    end
  end
end

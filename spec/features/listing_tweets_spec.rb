require 'rails_helper'

RSpec.feature "List Tweets" do
  before do
    @tweet1 = Tweet.create(body: "First Tweet")
    @tweet2 = Tweet.create(body: "Second Tweet")
  end

  scenario "User lists all tweets" do
    visit "/"

    expect(page).to have_content(@tweet1.body)
    expect(page).to have_link(@tweet1.body)
    expect(page).to have_content(@tweet2.body)
    expect(page).to have_link(@tweet2.body)
  end
end

require 'rails_helper'

RSpec.feature "Delete a Tweet" do
  before do
    @jake = User.create!(email: "jake@example.com", password: "password")
    login_as(@jake)
    @tweet = Tweet.create(body: "First Tweet", user: @jake)
  end

  scenario "User deletes a tweet" do
    visit "/"
    click_link @tweet.body
    click_link "Delete Tweet"

    expect(page).to have_content("Tweet has been deleted")
    expect(page.current_path).to eq(tweets_path)
  end

end
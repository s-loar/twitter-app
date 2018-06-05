require 'rails_helper'

RSpec.feature "Show a Tweet" do

  before do
    @tweet = Tweet.create(body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
  end

  scenario "to show a tweet" do
    visit '/'
    click_link @tweet.body

    expect(page).to have_content(@tweet.body)
    expect(page.current_path).to eq(tweet_path(@tweet))
  end
end
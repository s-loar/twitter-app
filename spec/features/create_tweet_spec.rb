require 'rails_helper'

RSpec.feature "Creating Tweets" do

  before do
    @jake = User.create!(email: "jake@example.com", password: "password", name: "Jake")
    login_as(@jake)
  end

  scenario "A user posts a new tweet" do
    visit "/"
    click_link "New Tweet"
    fill_in "Body", with: "Lorem Ipsum"
    click_button "Post"

    expect(Tweet.last.user).to eq(@jake)
    expect(page).to have_content("Tweet has been posted")
    expect(page.current_path).to eq(tweets_path)
    expect(page).to have_content("Created by: #{@jake.name} (#{@jake.email})")
  end

  scenario "A user fails to post a new tweet" do
    visit "/"
    click_link "New Tweet"
    fill_in "Body", with: ""
    click_button "Post"

    expect(page).to have_content("Tweet has not been posted")
    expect(page).to have_content("Body can't be blank")
  end
end
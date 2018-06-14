require 'rails_helper'

RSpec.feature "Like Tweets" do
  before do
    @jake = User.create!(email: "jake@example.com", password: "password", name: "Jake")
    @sally = User.create!(email: "sally@example.com", password: "password", name: "Sally")
    @tweet1 = Tweet.create(body: "First Tweet", user: @jake)
    @sally.follow(@jake)
  end
  scenario "User is signed and likes a tweet" do
    login_as(@sally)
    visit "/"
    expect(page).to have_content("0 Likes")
    click_link "Like"
    expect(page).to have_content("1 Likes")
  end

  scenario "User is signed and unlikes a tweet" do
    @sally.like!(@tweet1)
    login_as(@sally)
    visit "/"
    expect(page).to have_content("1 Likes")
    click_link "Undo like"
    expect(page).to have_content("0 Likes")
  end
end
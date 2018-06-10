require 'rails_helper'

RSpec.feature "Follow Users" do
  before do
    @jake = User.create!(email: "jake@example.com", password: "password", name: "Jake Davis")
    @sally = User.create!(email: "sally@example.com", password: "password", name: "Sally West")
    login_as(@sally)
  end

  scenario "permits a signed in user to follow another user" do
    visit '/'
    click_link 'Follow'
    expect(page).to have_content(@jake.name)
    expect(page).to have_button("Follow")
  end

  scenario "permits a signed in user to unfollow another user" do
    @sally.follow(@jake)
    visit '/'
    click_link 'Follow'
    expect(page).to have_content(@jake.name)
    expect(page).to have_button("Unfollow")
  end
end

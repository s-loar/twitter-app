require 'rails_helper'

RSpec.feature "Sign in Users" do

  before do
    @jake = User.create!(email: "jake@example.com", password: "password", name: "Jake")
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: @jake.email
    fill_in "Password", with: @jake.password
    click_button "Log in"
  end

  scenario "Sign out user" do
    visit "/"
    click_link "Sign out"
    expect(page).to have_content("Signed out successfully")
    expect(page).not_to have_content("Sign out")
    expect(page).to have_link("Sign in")
  end

end
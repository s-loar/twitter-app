require 'rails_helper'

RSpec.feature "Signup Users" do
  scenario "with valid credentials" do
    visit "/"
    click_link "Sign up"
    fill_in "Name", with: "user1"
    fill_in "Email", with: "user1@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"
    expect(page).to have_content("You have signed up successfully.")
  end

  scenario "with invalid credentials" do
    visit "/"
    click_link "Sign up"
    fill_in "Name", with: ""
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    click_button "Sign up"
    expect(page).to have_content("3 errors prohibited this user from being saved")
  end
end

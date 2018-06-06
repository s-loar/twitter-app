require 'rails_helper'

RSpec.feature "Sign in Users" do

  before do
    @jake = User.create!(email: "jake@example.com", password: "password")
  end

  scenario "with valid credentials" do
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: @jake.email
    fill_in "Password", with: @jake.password
    click_button "Log in"
    expect(page).to have_content("Signed in successfully")
    expect(page).to have_content("Signed in as #{@jake.email}")
    expect(page).not_to have_link("Sign in")
    expect(page).not_to have_link("Sign up")
  end

  scenario "with invalid credentials" do
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    click_button "Log in"
    expect(page).to have_content("Invalid Email or password")
    expect(page).to have_link("Sign in")
    expect(page).to have_link("Sign up")
  end
end

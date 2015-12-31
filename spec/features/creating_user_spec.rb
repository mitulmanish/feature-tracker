require "rails_helper"

RSpec.feature "Users can sign up" do
  scenario "when providing valid details" do
    visit "/"
    click_link "Sign Up"
    fill_in "Email", with: "user@feature_tracker.com"
    fill_in "user_password", with: "my_password"
    fill_in "Password confirmation", with: "my_password"
    click_button "Sign up"
    expect(page).to have_content("You have signed up successfully.")
  end
end
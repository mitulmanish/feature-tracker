require "rails_helper"
RSpec.feature "Users can sign in" do
  let!(:user) {FactoryGirl.create(:user)}
  scenario "with valid username and password" do
    visit "/"
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    click_button "Sign in"
    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Signed in as #{user.email}")
  end
end
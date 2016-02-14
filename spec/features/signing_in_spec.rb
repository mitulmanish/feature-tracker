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

  scenario "unless they are archived" do
    user.archive

    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: "password"

    expect(page).to have_content "Your account has been archived.Contact Admin"
  end
end
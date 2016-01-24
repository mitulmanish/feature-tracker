require "rails_helper"

RSpec.feature "Admin can create new user" do
  let(:admin) {FactoryGirl.create(:user, :admin)}

  before do
    login_as(admin)
    visit "/"
    click_link "Admin"
    click_link "Users"
    click_link "New User"
  end

  scenario "with valid credentials" do
    fill_in "Email", with: "mitul.manish@protonmail.com"
    fill_in "Password", with: "password"
    click_button "Create User"
    expect(page).to have_content "User has been created"
  end

  scenario "creating admin users" do
    fill_in "Email", with: "new_admin@feature_tracker.com"
    fill_in "Password", with: "strong_password"
    check "is an Admin?"
    click_button "Create User"
    expect(page).to have_content "User has been created"
  end

end
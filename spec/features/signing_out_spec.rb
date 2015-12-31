require "rails_helper"

RSpec.feature "Signed in users are able to d=sign out of the app" do
  let(:user) {FactoryGirl.create(:user)}

  before do
    login_as(user)
  end

  scenario do
    visit "/"
    click_link "Sign out"
    expect(page).to have_content "Signed out successfully."
  end

end
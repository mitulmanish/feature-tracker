require 'rails_helper'

RSpec.feature "An admin can achive users" do

  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:user)  { FactoryGirl.create(:user) }

  before do
    login_as(admin)
  end

  scenario "succesfully" do
    visit admin_user_path(user)
    click_link "Archive"

    expect(page).to have_content "User has been archived"
    expect(page).not_to have_content user.email
  end
end

require "rails_helper"

RSpec.feature "Users can create new tickets" do
  let(:user) {FactoryGirl.create(:user, :admin)}
  before do
    login_as(user)
    project = FactoryGirl.create(:project, name: "Slack", description: "Integration of slack with rails 4")
    visit project_path(project)
    click_link "New Ticket"
  end
  scenario "with valid attributes" do
    fill_in "Name", with: "Communication issues"
    fill_in "Description", with: "Not able to connect to rails backend"
    click_button "Create Ticket"
    expect(page).to have_content "New ticket created"
    expect(page).to have_content "Communication issues"
    within "#ticket" do
      expect(page).to have_content "Author: #{user.email}"
    end
  end
  scenario "with blank name and description attributes" do
    click_button "Create Ticket"
    expect(page).to have_content "Ticket could not be created"
  end
end
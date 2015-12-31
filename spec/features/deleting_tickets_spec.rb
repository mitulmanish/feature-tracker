require "rails_helper"
RSpec.feature "Users can delete tickets" do
  let(:user) {FactoryGirl.create(:user)}
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project, author: user) }
  before do
    visit project_ticket_path(project, ticket)
  end
  scenario "successfully" do
    click_link "Delete Ticket"
    expect(page).to have_content "Successfully deleted"
  end
end
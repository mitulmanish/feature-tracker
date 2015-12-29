require "rails_helper"
RSpec.feature "Users can delete ticket" do
  before do
    project = FactoryGirl.create(:project, name: "Rails Upgrade",
                                 description: "Upgradation to Rails 4 from 3")
    FactoryGirl.create(:ticket, project: project, name: "Tests failing",
                       description: "All the tests need to pass before migration" )
    visit "/"
  end
  scenario "when deleting tickets" do
    click_link "Rails Upgrade"
    expect(page).to have_content("Tests failing")
    click_link("Tests failing")
    expect(page).to have_content("All the tests need to pass before migration")
    click_link "Delete Ticket"
    expect(page).to have_content("Successfully deleted")
    expect(page).to have_no_content("Tests failing")
  end
end
require "rails_helper"
RSpec.feature "Users can edit ticket" do
  before do
    mandrill = FactoryGirl.create(:project, name: "Mandrill Integration",
                                  description: "Transactional emails to be sent through Mandrill")
    FactoryGirl.create(:ticket, project: mandrill, name: "No sender feild available" ,
                       description: "When sending emails sender field is blank")

    data_integrity = FactoryGirl.create(:project, name: "Data Corrupted",
                                        description: "the data in dog's table is corrupted")
    FactoryGirl.create(:ticket, project: data_integrity, name: "trailing --- in the database",
                       description: "Javascript plugin is causing the error" )
    visit "/"
  end
  scenario "when editing tickets" do
    click_link "Mandrill Integration"
    expect(page).to have_content("No sender feild available")
    click_link("No sender feild available")
    expect(page).to have_content("When sending emails sender field is blank")
    click_link "Edit Ticket"
    fill_in "Name", with: "No sender feild available now"
    fill_in "Description", with: "When sending emails sender field is blank."
    click_button "Update Ticket"
    expect(page).to have_content("Sucessfully Updated")
    expect(page).to have_content("No sender feild available now")
    expect(page).to have_content ("When sending emails sender field is blank.")
  end
end
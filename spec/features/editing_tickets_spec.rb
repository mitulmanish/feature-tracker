require "rails_helper"
RSpec.feature "Users can edit ticket" do
  before do
    user = FactoryGirl.create(:user, email: "xyx@abc.com", password: "password" )
    mandrill = FactoryGirl.create(:project, name: "Mandrill Integration",
                                  description: "Transactional emails to be sent through Mandrill")
    ticket = FactoryGirl.create(:ticket, project: mandrill, name: "No sender feild available" ,
                       description: "When sending emails sender field is blank", author: user)

    data_integrity = FactoryGirl.create(:project, name: "Data Corrupted",
                                        description: "the data in dog's table is corrupted")
    FactoryGirl.create(:ticket, project: data_integrity, name: "trailing --- in the database",
                       description: "Javascript plugin is causing the error", author: user )
    login_as(user)
    visit project_ticket_path(mandrill, ticket)
  end
  scenario "when editing tickets" do
    click_link "Edit Ticket"
    fill_in "Name", with: "No sender feild available now"
    fill_in "Description", with: "When sending emails sender field is blank."
    click_button "Update Ticket"
    expect(page).to have_content("Sucessfully Updated")
    expect(page).to have_content("No sender feild available now")
    expect(page).to have_content ("When sending emails sender field is blank.")
    within "#attributes" do
      expect(page).to have_content("Author: xyx@abc.com")
    end
  end
end
require "rails_helper"

RSpec.feature "Users can view tickets" do
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
   scenario "for a given project" do
     click_link "Mandrill Integration"
     expect(page).to have_content "Mandrill Integration"
     expect(page).to have_content "No sender feild available"
     click_link "No sender feild available"
     expect(page).to have_content("No sender feild available")
     expect(page).to_not have_content("trailing --- in the database")
   end
  scenario "for another project" do
    click_link "Data Corrupted"
    expect(page).to have_content "the data in dog's table is corrupted"
    click_link "trailing --- in the database"
    expect(page).to have_content("trailing --- in the database")
    expect(page).to_not have_content("No sender feild available")
  end
end
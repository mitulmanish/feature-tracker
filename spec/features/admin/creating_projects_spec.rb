require "rails_helper"
RSpec.feature "create projects" do
  before do
    login_as(FactoryGirl.create(:user, :admin))
    visit admin_root_path
    click_link "New Project"
  end

  scenario "with valid project name and desription" do
    fill_in "Name", with: "mitulManish"
    fill_in "Description", with: "Description of my project.Coolest description ever"
    click_button "Create Project"
    expect(page).to have_content "Project has been created"
    click_link "mitulManish"
    expect(page).to have_content("mitulManish")
    expect(page).to have_content("Description of my project.Coolest description ever")
  end
  scenario "creating a project with valid attributes and then deleting the project" do
    fill_in "Name", with: "mitulManish"
    fill_in "Description", with: "Description of my project.Coolest description ever"
    click_button "Create Project"
    expect(page).to have_content "Project has been created"
    click_link "mitulManish"
    click_link "Delete Project"
    expect(page).to have_no_content("mitulManish")
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "Project"
    fill_in "Description", with: "Description of my project"
    click_button "Create Project"
    expect(page).to have_content "Project has been created."
    click_link "New Project"
    fill_in "Name", with: "Project"
    fill_in "Description", with: "Some other description"
    click_button "Create Project"
    expect(page).to have_content "Project could not be created"
  end
  scenario "with blank project name" do
    fill_in "Description", with: "I am not entering a project name"
    click_button "Create Project"
    expect(page).to have_content("Name can't be blank")
  end
  scenario "with blank description" do
    fill_in "Name", with: "Project1"
    click_button "Create Project"
    expect(page).to have_content "Project could not be created"
    expect(page).to have_content("Description can't be blank")
  end

  scenario "with smaller title of project name" do
    fill_in "Name", with: "Sml"
    fill_in "Description", with: "Description is of appropriate length"
    click_button "Create Project"
    expect(page).to have_content "Project could not be created"
  end
  scenario "with smaller description of project name" do
    fill_in "Name", with: "Sml"
    fill_in "Description", with: "Descrip"
    click_button "Create Project"
    expect(page).to have_content "Project could not be created"
  end
  scenario "creating a project without name and description" do
    click_button "Create Project"
    expect(page).to have_content "Project could not be created"
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Name is too short (minimum is 4 characters)"
    expect(page).to have_content "Description can't be blank"
    expect(page).to have_content "Description is too short (minimum is 10 characters)"
  end
  end
  RSpec.describe ProjectsController, type: :controller do
    it "handles a missing project correctly" do
      get :show, id: "not-here"
      expect(response).to redirect_to(projects_path)
      message = "Project you are looking for can't be found"
      expect(flash[:notice]).to eq message
    end
  end



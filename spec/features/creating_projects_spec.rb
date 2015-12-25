require "rails_helper"
RSpec.feature "create projects" do

  before do
    visit "/"
    click_link "New Project"
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

  RSpec.feature "Edit project" do
    before do
      @project = FactoryGirl.create(:project, name: "Atlassian", description: "just another project")
      #project = Project.create!(name: "Atlassian", description: "just another project")
      visit "/"
      click_link @project.name
      expect(page.current_url).to eq project_url(@project)
      expect(page).to have_content(@project.name)
    end
    scenario "when user clicks on the projcet's name " do
      click_link "Edit Project"
      fill_in "Name", with: "Atlassian11"
      click_button "Update Project"
      expect(page).to have_content "Project has been updated."
      expect(page).to have_content "Atlassian11"
    end
    scenario "when deleting a project" do
      click_link "Delete Project"
      expect(page).to have_content "Project has been deleted"
      expect(page).to have_no_content("Atlassian11")
      expect(page.current_url).to eq("http://www.example.com/projects")
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



class ProjectsController < ApplicationController
  before_action :find_project , only: [:edit, :update, :show]

  def index
    @projects = Project.all
  end

  def edit

  end

  def update
    @project.update!(project_params)
    flash[:notice] = "Project has been updated."
    redirect_to @project
  end

  def show
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def find_project
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Project you are looking for can't be found"
    redirect_to projects_path
  end

end

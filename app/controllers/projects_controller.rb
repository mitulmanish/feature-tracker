class ProjectsController < ApplicationController
  before_action :find_project , only: [:edit, :update, :show]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end
  def edit

  end

  def update
    @project.update!(project_params)
    flash[:notice] = "Project has been updated."
    redirect_to @project
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:notice] = "Project has been deleted"
    redirect_to projects_path
  end

  def show
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:notice] = "Project has been created."
      redirect_to projects_path
    else
      flash.now[:alert] = "Project could not be created"
      render "new"
    end
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

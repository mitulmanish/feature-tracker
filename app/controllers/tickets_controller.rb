class TicketsController < ApplicationController
  before_action :find_project
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def index
    @tickets = @project.tickets.all
  end

  def show
  end

  def edit
  end

  def update
    @ticket.update(ticket_params)
    flash[:notice] = "Sucessfully Updated"
    redirect_to project_ticket_path(@project,@ticket)
  end

  def destroy
    @ticket.destroy
    flash[:notice] = "Successfully deleted"
    redirect_to project_tickets_path
  end

  def new
    @ticket = @project.tickets.build
  end

  def create
    @ticket = @project.tickets.build(ticket_params)
    @ticket.author = current_user
    if @ticket.save
      flash[:notice] = "New ticket created"
      redirect_to project_ticket_path(@project, @ticket)
    else
      flash[:alert] = "Ticket could not be created"
      render "new"
    end
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Project you are looking for can't be found"
    redirect_to projects_path
  end

  def ticket_params
    params.require(:ticket).permit(:name, :description)
  end

  def set_ticket
    @ticket = @project.tickets.find(params[:id])
  end
end

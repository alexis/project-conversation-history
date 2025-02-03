class ProjectsController < ApplicationController
  before_action :set_project, except: [ :index ]

  def show
    @project_changes = @project.project_changes.includes(:comment, :user)
  end

  def update
    @project.assign_attributes(project_params)
    if @project.save_with_project_change(as: current_user)
      redirect_to @project, notice: "Project status updated successfully."
    else
      render :show, alert: "Failed to update project status."
    end
  end

  def index
    @projects = current_user.projects
  end

  private

  def project_params
    params.require(:project).permit(:status)
  end

  def set_project
    @project = current_user.projects.find(params[:id])
  end
end

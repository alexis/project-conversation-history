class ProjectsController < ApplicationController
  before_action :set_project

  def show
    render html: "XXX", layout: true
  end

  private

  def project_params
    params.require(:project).permit(:status)
  end

  def set_project
    @project = current_user.projects.find(params[:id])
  end
end

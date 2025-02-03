class CommentsController < ApplicationController
  before_action :set_project

  def create
    @comment = @project.comments.build(comment_params.merge(user: current_user))
    if @comment.save_with_project_change(as: current_user)
      redirect_to project_path(@project, anchor: "comment-#{@comment.id}"), notice: "Comment added!"
    else
      redirect_to project_path(@project), alert: "Failed to add a comment."
    end
  end

  def destroy
    @comment = @project.comments.find(params[:id])
    return unless @comment.user == current_user
    if @comment.delete_with_project_change(as: current_user)
      redirect_to project_path(@project, anchor: "comment-#{@comment.id}"), notice: "Comment deleted."
    else
      redirect_to project_path(@project), alert: "Failed tot delete a comment."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_project
    @project = current_user.projects.find(params[:project_id])
  end
end

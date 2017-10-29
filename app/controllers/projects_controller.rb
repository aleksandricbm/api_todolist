class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def create
    @project = current_user.projects.create(permit_params)
    if @project.save
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: current_user.projects.all
  end

  def permit_params
    params.require(:project).permit(:name)
  end
end

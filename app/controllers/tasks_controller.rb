class TasksController < ApplicationController
  before_action :authenticate_user!

  def create
    @task = current_user.projects.find(params[:project]).tasks.new(permit_params)
    if @task.save
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: current_user.projects.find(params[:project]).tasks.all
  end

  private

  def permit_params
    params.require(:task).permit(:name)
  end
end

class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: find_project(params[:project]).tasks.all
  end

  def create
    @task = find_project(params[:params][:project]).tasks.new(permit_params)
    if @task.save
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.projects.find(params[:name]).destroy
  end

  def sort
    tasks = find_project(params[:proj_id]).tasks
    permit_sort_update.each do |attr|
      tasks.find(attr[:id]).update(position: attr[:position])
    end
    render nothing: true
  end

  def completed
    find_project(params[:proj_id]).tasks.find(params[:task_id]).set_completed
  end

  private

  def permit_params
    params.require(:params).permit(:name)
  end

  def permit_sort_update
    params.permit(params: [:id, :position])[:params]
  end

  def find_project(id)
    current_user.projects.find(id)
  end
end

class TasksController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :project
  load_and_authorize_resource :task, through: :project

  def index
    render json: @tasks
  end

  def create
    if @task.save
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def update
    if @task.update_attributes(update_params)
    end
  end

  def destroy
    @task.destroy
  end

  def sort
    permit_sort_update.each do |attr|
      @tasks.find(attr[:id]).update(position: attr[:position])
    end
    render nothing: true
  end

  def completed
    @task.set_completed
  end

  private

  def create_params
    params.permit(:name)
  end

  def update_params
    params.permit(:name)
  end

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

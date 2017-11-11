class Api::V1::TasksController < ApplicationController
  respond_to :json
  before_action :authenticate_user!
  load_and_authorize_resource :project
  load_and_authorize_resource :task, through: :project

  def_param_group :tasks do
    param :params, Array, of: Hash do
      param :id, Integer, required: true
      param :project_id, Integer, required: true
      param :position, Integer, required: true
    end
  end

  api :GET, 'tasks', 'Get list tasks a current project to user'
  param :project_id, String, required: true
  def index
    render json: @tasks
  end

  api :POST, 'tasks', 'Create task a current project to user'
  param :project_id, Integer, required: true
  param :name, String, required: true
  def create
    if @task.save
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  api :POST, 'tasks/:id', 'Update some task a current project to user'
  param :id, String, required: true
  param :project_id, Integer, required: true
  param :name, String, required: true
  def update
    if @task.update_attributes(update_params)
    end
  end

  api :DELETE, 'tasks/:id', 'Delete some task a current project to user'
  param :id, String, required: true
  param :project_id, String, required: true
  def destroy
    @task.destroy
  end

  api :PUT, 'tasks/sort', 'Change task position'
  param :project_id, Integer, required: true
  param_group :tasks
  def sort
    permit_sort_update.each do |attr|
      @tasks.find(attr[:id]).update(position: attr[:position])
    end
    render nothing: true
  end

  api :PUT, 'tasks/:id/completed', 'Change status task'
  param :id, String, required: true
  param :project_id, Integer, required: true
  def completed
    @task.set_completed
  end

  api :PUT, 'tasks/:id/deadline', 'Change deadline'
  param :id, String, required: true
  param :project_id, Integer, required: true
  param :deadline, String, required: true
  def deadline
    @task.set_deadline(params[:deadline])
  end

  private

  def create_params
    params.permit(:name)
  end

  def update_params
    params.permit(:name)
  end

  def permit_sort_update
    params.permit(params: [:id, :position])[:params]
  end
end

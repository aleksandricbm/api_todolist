class Api::V1::TasksController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :project
  load_and_authorize_resource :task, through: :project

  include Update_task

  def_param_group :task do
    param :task, Hash, action_aware: true, required: true do
      param :name, String, required: true
      param :direction, String, required: false
    end
  end

  api :GET, 'tasks', 'Get list tasks a current project to user'
  param :project_id, String, required: true
  def index
    render json: @tasks
  end

  api :POST, 'tasks', 'Create task a current project to user'
  param :project_id, :number, required: true
  param_group :task
  def create
    if @task.save
      render json: @task
    else
      render json: @task.errors, status: 422
    end
  end

  api :PUT, 'tasks/:id', 'Update some task a current project to user'
  param :id, :number, required: true
  param_group :task
  def update
    update_params(params)
    if @task.errors.present?
      render json: @task.errors, status: 422
    else
      render json: @project.tasks, status: 200
    end
  end

  api :DELETE, 'tasks/:id', 'Delete some task a current project to user'
  param :id, String, required: true
  param :project_id, String, required: true
  def destroy
    if @task.destroy
      render json: @task, status: 204
    else
      render json: @task.errors, status: 422
    end
  end

  private

  def task_params
    params.require(:task).permit(:name)
  end
end

class Api::V1::ProjectsController < ApplicationController
  respond_to :json
  before_action :authenticate_user!
  load_and_authorize_resource through: :current_user

  def_param_group :project do
    param :project, Hash, action_aware: true, required: true do
      param :name, String, required: true
    end
  end

  api :GET, 'projects', 'Get users project list'
  def index
    render json: @projects
  end

  api :POST, 'projects', 'Create project for user'
  param_group :project
  def create
    if @project.save
      render json: @project
    else
      render json: @project.errors, status: 422
    end
  end

  api :PATCH, 'projects/:id', 'Update some project'
  param :id, String, required: true
  param_group :project
  def update
    if @project.update_attributes(project_params)
      render json: @project, status: 200
    else
      render json: @project.errors, status: 422
    end
  end

  api :DELETE, 'projects/:id', 'Delete some project'
  param :id, String, required: true
  def destroy
    if @project.destroy
      render json: @project, status: 204
    else
      render json: @project.errors, status: 422
    end
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end

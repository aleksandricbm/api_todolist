class Api::V1::ProjectsController < ApplicationController
  respond_to :json
  before_action :authenticate_user!
  load_and_authorize_resource through: :current_user

  def_param_group :project do
    param :params, Hash, action_aware: true, required: true do
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
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  api :PATCH, 'projects/:id', 'Update some project'
  param :id, String, required: true
  param_group :project
  def update
    if @project.update_attributes(update_params)
    end
  end

  api :DELETE, 'projects/:id', 'Delete some project'
  param :id, String, required: true
  def destroy
    @project.destroy
  end

  private

  def create_params
    params.require(:params).permit(:id, :name)
  end

  def update_params
    params.require(:params).permit(:name)
  end

  def permit_id
    params.require(:params).permit(:id).id
  end

end

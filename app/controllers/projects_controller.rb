class ProjectsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource through: :current_user

  def index
    render json: @projects
  end

  def create
    if @project.save
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def update
    if @project.update_attributes(update_params)
    end
  end

  def destroy
    @project.destroy
  end

  private

  def create_params
    params.require(:params).permit(:id, :name)
  end

  def update_params
    params.permit(:name)
  end

  def permit_id
    params.require(:params).permit(:id).id
  end

end

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

  def update
    current_user.projects.find(params[:params][:id]).update(permit_params)
  end

  def destroy
    current_user.projects.find(params[:name]).destroy
  end

  private

  def permit_params
    params.require(:params).permit(:name, :id)
  end

  def permit_id
    params.require(:params).permit(:id).id
  end

end

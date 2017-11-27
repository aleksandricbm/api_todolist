class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :task
  load_and_authorize_resource :comment, through: :task

  def_param_group :find do
    param :project_id, :number, required: true
    param :task_id, :number, required: true
  end

  def_param_group :comment do
    param :data, Hash, action_aware: true, required: true do
      param :comment, String, required: true
      param :file, String, required: false
    end
  end

  api :GET, 'comments', 'Get list comments a current task'
  param_group :find
  def index
    render json: @comments
  end

  api :POST, 'comments', 'Create comment a current task'
  param_group :find
  param_group :comment
  def create
    if @comment.save
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, 'comments/:id', 'Delete comment a current task'
  param :id, String, required: true
  param :project_id, String, required: true
  param :task_id, String, required: true
  def destroy
    @comment.destroy
  end

  private

  def comment_params
    params.require(:data).permit(:comment, :file)
  end
end

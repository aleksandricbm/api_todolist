class Api::V1::CommentsController < ApplicationController
  respond_to :json
  before_action :authenticate_user!
  load_and_authorize_resource :task
  load_and_authorize_resource :comment, through: :task

  def_param_group :data do
    param :params, Hash do
      param :comment, String, required: true
      param :project_id, Integer, required: true
      param :task_id, Integer, required: true
    end
  end

  api :GET, 'comments', 'Get list comments a current task'
  param :project_id, String, required: true
  param :task_id, String, required: true
  def index
    render json: @comments
  end

  api :POST, 'comments', 'Create comment a current task'
  param_group :data
  def create
    if @comment.save
      @comment.task.increase_comments_qty
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

  def create_params
    params.permit(:comment, :file)
  end
end

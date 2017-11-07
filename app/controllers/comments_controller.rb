class CommentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :task
  load_and_authorize_resource :comment, through: :task

  def index
    render json: @comments
  end

  def create
    if @comment.save
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
  end

  private

  def create_params
    params.permit(:comments, :file)
  end
end

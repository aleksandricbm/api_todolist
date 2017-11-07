class CommentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :task
  load_and_authorize_resource :comment, through: :task

  def index
  end

  def create
    @comment.save
  end

  private

  def create_params
    params.permit(:comments, :file)
  end
end

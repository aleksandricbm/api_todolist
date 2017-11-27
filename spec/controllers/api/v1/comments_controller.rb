require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:project) { create(:project, user_id: user.id) }
  let(:task) { create(:task, project_id: project.id) }
  let(:comment) { create(:comment, task_id: task.id) }
  let(:params_valid) { 'Test Comment' }
  let(:params_invalid) { '' }

  describe 'GET #index' do
    it 'not auth user' do
      get :index
      expect(response).to have_http_status 401
    end

    it 'auth user and get list comments', :show_in_doc do
      auth_request(user)
      comment
      get :index, { params: { project_id: project.id, task_id: task.id, data: { comment: params_invalid } } }
      expect(response).to have_http_status 200
      expect(response).to match_response_schema('comments')
    end
  end

  describe 'POST #create' do
    it 'not auth user' do
      post :create, { params: { project_id: project.id, task_id: task.id } }
      expect(response).to have_http_status 401
    end

    context 'auth user' do
      before { auth_request(user) }

      it 'create comment', :show_in_doc do
        post :create, { params: { project_id: project.id, task_id: task.id, data: { comment: params_valid } } }
        expect(response).to have_http_status 200
        expect(response).to match_response_schema('project')
        task.reload
        expect(task.comments_qty).to eq 1
      end

      it 'invalid comment' do
        post :create, { params: { project_id: project.id, task_id: task.id, data: { comment: params_invalid } } }
        expect(response).to have_http_status 422
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'not auth user', :show_in_doc do
      delete :destroy, params: { project_id: project.id, task_id: task.id, id: comment.id }
      expect(response).to have_http_status 401
    end

    context 'auth user' do
      before { auth_request(user) }

      it 'destroy comment', :show_in_doc do
        delete :destroy, params: { project_id: project.id, task_id: task.id, id: comment.id }
        expect(response).to have_http_status 204
        expect(Comment.count).to eq 0
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:project) { create(:project, user_id: user.id) }
  let(:task) { create(:task, project_id: project.id) }
  let(:params_valid) { 'Test Task' }
  let(:params_invalid) { '' }

  describe 'includes the correct concerns' do
    it { expect(controller.class.ancestors.include?(Api::V1::Update_task)).to eq(true) }
  end

  describe 'GET #index' do
    it 'not auth user' do
      get :index
      expect(response).to have_http_status 401
    end

    it 'auth user and get list tasks', :show_in_doc do
      auth_request(user)
      task
      get :index, params: { project_id: project.id }
      expect(response).to have_http_status 200
      expect(response).to match_response_schema('tasks')
    end
  end

  describe 'POST #create' do
    it 'not auth user' do
      post :create, params: { project_id: project.id, task: { name: params_valid } }
      expect(response).to have_http_status 401
    end

    context 'auth user' do
      before { auth_request(user) }

      it 'create task', :show_in_doc do
        post :create, params: { project_id: project.id, task: { name: params_valid } }
        expect(response).to have_http_status 200
        expect(response).to match_response_schema('task')
      end
    end
  end

  describe 'PUT #update' do
    it 'not auth user', :show_in_doc do
      put :update, params: { project_id: project.id, id: task.id }
      expect(response).to have_http_status 401
    end

    context 'auth user' do
      before { auth_request(user) }

      it 'update task name', :show_in_doc do
        put :update, params: { project_id: project.id, id: task.id, task: { name: params_valid } }
        expect(response).to have_http_status 200
        expect(response).to match_response_schema('tasks')
      end

      it 'change direction up', :show_in_doc do
        put :update, params: { project_id: project.id, id: task.id, task: { direction: 'up' } }
        expect(response).to have_http_status 200
        expect(response).to match_response_schema('tasks')
      end

      it 'change direction down', :show_in_doc do
        put :update, params: { project_id: project.id, id: task.id, task: {  direction: 'donw' } }
        expect(response).to have_http_status 200
        expect(response).to match_response_schema('tasks')
      end

      it 'set_completed check', :show_in_doc do
        put :update, params: { project_id: project.id, id: task.id, completed: 1, task: {  completed: 1 } }
        expect(response).to have_http_status 200
        expect(response).to match_response_schema('tasks')
        task.reload
        expect(task.completed).to be true
      end

      it 'set_deadline check' do
        put :update, params: { project_id: project.id, id: task.id, deadline: DateTime.now, task: { deadline: DateTime.now } }
        expect(response).to have_http_status 200
        expect(response).to match_response_schema('tasks')
        task.reload
        expect(task.deadline).not_to be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'not auth user', :show_in_doc do
      delete :destroy, params: { project_id: project.id, id: task.id }
      expect(response).to have_http_status 401
    end

    context 'auth user' do
      before { auth_request(user) }

      it 'destroy task', :show_in_doc do
        delete :destroy, params: { project_id: project.id, id: task.id }
        expect(response).to have_http_status 204
      end
    end
  end
end

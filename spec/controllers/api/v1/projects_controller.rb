require 'rails_helper'

RSpec.describe Api::V1::ProjectsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, user_id: user.id) }
  let(:params_valid) { { name: 'Test' } }
  let(:params_invalid) { { name: '' } }

  describe 'GET #index' do
    it 'not auth user' do
      get :index
      expect(response).to have_http_status 401
    end

    it 'auth user and get list projects', :show_in_doc do
      auth_request(user)
      project
      get :index
      expect(response).to have_http_status 200
      expect(response).to match_response_schema('projects')
    end
  end

  describe 'POST #create' do
    it 'not auth user' do
      post :create, params: { project: params_valid }
      expect(response).to have_http_status 401
    end

    context 'auth user' do

      before { auth_request(user) }

      it 'create project', :show_in_doc do
        post :create, params: { project: params_valid }
        expect(response).to have_http_status 200
        expect(response).to match_response_schema('project')
      end

      it 'invalid project' do
        post :create, params: { project: params_invalid }
        expect(response).to have_http_status 422
      end
    end
  end

  describe 'PATCH #update' do
    it 'not auth user', :show_in_doc do
      patch :update, params: { id: project.id }
      expect(response).to have_http_status 401
    end

    context 'auth user' do

      before { auth_request(user) }

      it 'update project name', :show_in_doc do
        patch :update, params: { id: project.id, project: params_valid }
        expect(response).to have_http_status 200
        expect(response).to match_response_schema('project')
      end

      it 'invalid project' do
        patch :update, params: { id: project.id, project: params_invalid }
        expect(response).to have_http_status 422
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'not auth user', :show_in_doc do
      delete :destroy, params: { id: project.id }
      expect(response).to have_http_status 401
    end

    context 'auth user' do

      before { auth_request(user) }

      it 'destroy project', :show_in_doc do
        delete :destroy, params: { id: project.id }
        expect(response).to have_http_status 204
      end
    end
  end
end

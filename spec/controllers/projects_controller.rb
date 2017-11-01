require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  # let!(:user) { FactoryGirl.create(:user) }


  describe "GET #show" do
    login_with FactoryGirl.create( :user )
    # before { sign_in user }
    # before { get :show }

    it 'returns HTTP status 200' do
      get :show
      expect(response).to have_http_status 200
    end
  end
end

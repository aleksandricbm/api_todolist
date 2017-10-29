Rails.application.routes.draw do
  scope '/api' do
    mount_devise_token_auth_for 'User', at: '/auth'
    resource :projects, only: %i[create show destroy]
    resource :tasks, only: %i[create show destroy]
  end
end

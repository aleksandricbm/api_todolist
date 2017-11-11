Rails.application.routes.draw do
  apipie
  mount_devise_token_auth_for 'User', at: '/api/auth'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :projects
      resources :tasks do
        put :sort, on: :collection
        member do
          put :completed
          put :deadline
        end
      end
      resources :comments
    end
  end
end

Rails.application.routes.draw do
  scope '/api' do
    mount_devise_token_auth_for 'User', at: '/auth'
    resources :projects
    resources :tasks do
      put :sort, on: :collection
      member do
        put :completed
      end
    end
    resources :comments
  end
end

Rails.application.routes.draw do
  root to: 'home#index'
  namespace :api,{ format: 'json' } do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }
    end
    
    namespace :v1 do
      resources :users
      resources :posts do
        resource :favorites, only: [:create, :destroy]
        resource :comments, only: [:create, :update, :destroy]
      end
      resources :restaurants
    end
  end

  get '*path', to: "home#index"
end

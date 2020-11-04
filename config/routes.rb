Rails.application.routes.draw do
  root to: 'home#index'

  namespace :api,{ format: 'json' } do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }
    end
    
    namespace :v1 do
      resources :users do
        member  do
          get 'posts'
          get 'follows'
          get 'comments'
        end
        resource :relationships, only: [:create, :destroy]
      end
      resources :replys, only: [:update, :destroy]
      resources :comments, only: [:update, :destroy]
      # patch '/replys/:reply_id', to: 'replys#update'
      # patch '/comments/:comment_id', to: 'comments#update'

      resources :posts do
        resource :favorites, only: [:create, :destroy]
        resources :comments, only: [:create, :update, :destroy] do
          # resources :replys, only: [:create, :destroy]
        end
      end
      resources :restaurants
    end
  end

  get '*path', to: "home#index"
end

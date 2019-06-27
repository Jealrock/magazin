Rails.application.routes.draw do
	root 'frontend#index'

  mount_devise_token_auth_for 'User',
                              at: 'api/v1/auth',
                              defaults: { format: 'json' },
                              skip: [:omniauth_callbacks]

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      mount ActionCable.server => '/cable'

      resources :users, only: %i[update show] do
        collection do
          get :offers
        end
      end
      resources :favorites, only: %i[index create destroy]
      resources :category_subscriptions, only: %i[index create destroy]
      resources :messages, only: %i[index create]
      resources :message_threads, only: %i[index]
      resources :geolocations, only: %i[index]
      resources :subscriptions, only: %i[create]
      resources :categories, only: %i[index]
      resources :offers, only: %i[index show create update] do
        member do
          post :close
          post :notify
        end
      end
    end
  end

	get '*path' => 'frontend#index'
end

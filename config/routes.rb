Rails.application.routes.draw do
	root 'frontend#index'

  mount_devise_token_auth_for 'User',
                              at: 'api/v1/auth',
                              defaults: { format: 'json' },
                              skip: [:omniauth_callbacks]

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[update]

      resources :favorites, only: %i[index create destroy]

      resources :geolocations, only: %i[index]
      resources :subscriptions, only: %i[create]

      resources :offers, only: %i[index show create] do
        member do
          post :close
          post :notify
        end
      end
    end
  end

	get '*path' => 'frontend#index'
end

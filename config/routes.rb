Rails.application.routes.draw do
	root 'frontend#index'

  mount_devise_token_auth_for 'User',
                              at: 'api/v1/auth',
                              defaults: { format: 'json' },
                              skip: [:omniauth_callbacks]

	get '*path' => 'frontend#index'
end

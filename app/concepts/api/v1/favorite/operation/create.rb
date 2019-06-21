module Api::V1::Favorite
  class Create < ApplicationOperation
    step Policy::Pundit(FavoritePolicy, :create?)
    failure :authorization_error!, fail_test: true
    step :create_favorite!
    step :get_offer!

    private

    def create_favorite!(options, current_user:, params:, **)
      favorite = Favorite.create!(user_id: current_user.id, offer_id: params['offer_id'])
      options['model'] = favorite
    end

    def get_offer!(options, model:, **)
      offer = model.offer
      options['model'] = offer
    end
  end
end

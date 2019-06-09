module Api::V1::Favorite
  class Destroy < ApplicationOperation
    step :find!
    failure :not_found!, fail_test: true
    step :destroy!
    step :get_offer!

    def find!(options, params:, current_user:, **)
      options['model'] = current_user.favorites.find_by(offer_id: params['id'])
    end

    def destroy!(_options, model:, **)
      model.destroy!
      model
    end

    def get_offer!(options, model:, **)
      offer = model.offer
      options['model'] = offer
    end
  end
end

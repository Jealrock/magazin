module Api::V1::Favorite
  class Destroy < ApplicationOperation
    step :find!
    failure :not_found!, fail_test: true
    step :destroy!

    def find!(options, params:, current_user:, **)
      options['model'] = current_user.favorites.find_by(offer_id: params['id'])
    end

    def destroy!(_options, model:, **)
      model.destroy!
    end
  end
end

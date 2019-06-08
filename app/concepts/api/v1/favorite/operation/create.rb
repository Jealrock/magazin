module Api::V1::Favorite
  class Create < ApplicationOperation
    step Policy::Pundit(FavoritePolicy, :create?)
    failure :invalid!, fail_test: true
    step Model(Favorite, :new)
    step :add_user_id!
    step :add_offer_id!
    step :save!
    step :get_offer!

    private

    def add_offer_id!(_options, model:, params:, **)
      model.offer_id = params['offer_id']
      model
    end

    def save!(_options, model:, **)
      model.save!
      model
    end

    def get_offer!(options, model:, **)
      offer = model.offer
      options['model'] = offer
    end
  end
end

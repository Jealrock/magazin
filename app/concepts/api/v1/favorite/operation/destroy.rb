module Api::V1::Favorite
  class Destroy < ApplicationOperation
    step :model!

    def model!(_options, params:, **)
      Favorite.find_by_offer_id(params['id']).destroy!
    end
  end
end

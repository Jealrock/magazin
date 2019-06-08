module Api::V1::Favorite
  class Index < ApplicationOperation
    step :model!

    def model!(options, current_user:, **)
      options['model'] = current_user.favorite_offers
    end
  end
end

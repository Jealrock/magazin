module Api::V1::Favorite
  class Index < ApplicationOperation
    step :model!

    def model!(options, current_user:, **)
      options['model'] = User.find(current_user.id).favorite_offers
    end
  end
end

module Api::V1::User
  class Offers < ApplicationOperation
    step :get_offer!

    private

    def get_offer!(options, current_user:, **)
      options['model'] = current_user.offers
      options['model']
    end
  end
end

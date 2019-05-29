module Api::V1::Offer
  class Close < ApplicationOperation
    step Model(Offer, :find_by)
    failure :not_found!, fail_fast: true
    step Policy::Pundit(OfferPolicy, :close?)
    failure :authorization_error!
    step :close!

    private

    def close!(_options, model:, **)
      model.close!
      model
    end
  end
end

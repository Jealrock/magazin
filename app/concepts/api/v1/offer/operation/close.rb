module Api::V1::Offer
  class Close < ApplicationOperation
    step Model(Offer, :find_by)
    failure :not_found!, fail_fast: true
    step Policy::Pundit(OfferPolicy, :show?)
    failure :authorization_error!
  end
end

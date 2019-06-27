module Api::V1::Offer
  class Edit < ApplicationOperation
    step Model(Offer, :find_by)
    failure :not_found!, fail_test: true
    step Policy::Pundit(OfferPolicy, :edit?)
    failure :authorization_error!, fail_tes: true
  end
end

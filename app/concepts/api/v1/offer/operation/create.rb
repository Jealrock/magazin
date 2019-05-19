module Api::V1::Offer
  class Create < ApplicationOperation
    step Policy::Pundit(OfferPolicy, :create?)
    failure :authorization_error!, fail_fast: true
    step Model(Offer, :new)
    step Contract::Build(constant: Offer::Contract::Create)
    step Contract::Validate()
    failure :invalid!
    step Contract::Persist()
  end
end

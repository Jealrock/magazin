module Api::V1::Offer
  class Update < ApplicationOperation
    step Model(Offer, :find_by)
    failure :not_found!, fail_test: true
    step Policy::Pundit(OfferPolicy, :update?)
    failure :authorization_error!, fail_test: true
    step Contract::Build(builder: :contract_builder!)
    step Contract::Validate()
    failure :invalid!
    step Contract::Persist()

    private

    def contract_builder!(_options, model:, params:, **)
      {
        'CashOffer' => CashOffer::Contract::Create.new(model),
        'ExchangeOffer' => ExchangeOffer::Contract::Create.new(model),
        'FreeOffer' => FreeOffer::Contract::Create.new(model),
        'ServiceOffer' => ServiceOffer::Contract::Create.new(model)
      }[params[:type]]
    end
  end
end

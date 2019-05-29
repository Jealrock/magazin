module Api::V1::Offer
  class Create < ApplicationOperation
    step Policy::Pundit(OfferPolicy, :create?)
    failure :authorization_error!, fail_fast: true
    step Model(Offer, :new)
    step :add_user_id!
    step Contract::Build(builder: :contract_builder!)
    step Contract::Validate()
    failure :invalid!
    step Contract::Persist()

    private

    def contract_builder!(_options, model:, params:, **)
      {
        'CashOffer' => CashOffer::Contract::Create.new(model),
        'ExchangeOffer' => ExchangeOffer::Contract::Create.new(model),
        'FreeOffer' => FreeOffer::Contract::Create.new(model)
      }[params[:type]]
    end
  end
end

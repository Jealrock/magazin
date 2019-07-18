module Api::V1::Offer
  class Update < ApplicationOperation
    step Model(Offer, :find_by)
    failure :not_found!, fail_test: true
    step Policy::Pundit(OfferPolicy, :update?)
    failure :authorization_error!, fail_test: true
    step Contract::Build(builder: :contract_builder!)
    step Contract::Validate()
    failure :invalid!
    step :build_photos!
    step Contract::Persist()

    private

    def contract_builder!(_options, model:, **)
      {
        'CashOffer' => CashOffer::Contract::Create.new(model),
        'ExchangeOffer' => ExchangeOffer::Contract::Create.new(model),
        'FreeOffer' => FreeOffer::Contract::Create.new(model),
        'ServiceOffer' => ServiceOffer::Contract::Create.new(model),
        'ShopOffer' => ShopOffer::Contract::Create.new(model)
      }[model.type]
    end

    def build_photos!(_options, model:, params:, **)
      params_photos = params[:photos] || []
      photos = params_photos.map { |file| Photo.new(file: file) }

      model.photos.destroy_all unless model.photos.empty?
      model.photos = photos

      model
    end
  end
end

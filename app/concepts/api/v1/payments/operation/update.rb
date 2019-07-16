module Api::V1::Payments
  class Update < ApplicationOperation
    step Model(Payment, :find_by)
    failure :not_found!, fail_test: true
    step Policy::Pundit(PaymentPolicy, :update?)
    failure :authorization_error!, fail_fast: true
    step Contract::Build(builder: :contract_builder!)
    step Contract::Validate()
    failure :invalid!
    step Contract::Persist()

    private

    def contract_builder!(_options, model:, **)
      "#{model.class}::Contract::Update".constantize.new(model)
    end
  end
end

module Api::V1::Payments
  class Update < ApplicationOperation
    step Model(Payment, :find_by)
    failure :not_found!, fail_test: true
    step Policy::Pundit(PaymentPolicy, :update?)
    failure :authorization_error!, fail_fast: true
    step :update_params! # TODO: get it work with contract

    private

    def update_params!(_options, model:, params:, **)
      model.params = params['params']
      model.save
    end

    def contract_builder!(_options, model:, **)
      "#{model.type}::Contract::Create".constantize.new(model)
    end
  end
end

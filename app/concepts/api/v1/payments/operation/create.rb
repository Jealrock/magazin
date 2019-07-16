module Api::V1::Payments
  class Create < ApplicationOperation
    step Model(Payment, :new)
    step Policy::Pundit(PaymentPolicy, :create?)
    failure :authorization_error!, fail_fast: true
    step :set_type!
    step Contract::Build(builder: :contract_builder!)
    step Contract::Validate()
    failure :invalid!
    step Contract::Persist()
    step :update_model_sti_class!

    private

    def set_type!(_options, model:, params:, **)
      model.becomes!(::Payments::Notification) if params[:type] == 'Notification'
    end

    def contract_builder!(_options, model:, params:, **)
      "Payments::#{params[:type]}::Contract::Create".constantize.new(model)
    end

    def update_model_sti_class!(options, **)
      options['model'] = Payment.find(options['model'].id)
    end
  end
end

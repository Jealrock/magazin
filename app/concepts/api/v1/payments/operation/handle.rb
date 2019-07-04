module Api::V1::Payments
  class Handle < ApplicationOperation
    step :model!
    failure :not_found!, fail_fast: true
    failure :process_payment!

    private

    def model!(options, params:, **)
      options['model'] = Payment.find_by(megakassa_order_id: params['order_id'])
    end

    def process_payment!(_options, params:, model:, **)
      if model && params['status'] == 'success'
        model.process
        model.success!
      else
        model&.failure!
      end
    end
  end
end

module Api::V1::Payments
  class Handle < ApplicationOperation
    step :model!
    failure :not_found!, fail_fast: true
    step :process_payment!

    private

    def model!(options, params:, **)
      options['model'] = Payment.find_by(id: params['order_id'].to_i)
    end

    def process_payment!(_options, params:, model:, **)
      model.freekassa_uid = params['intid']

      model.process
      model.successful!
    end
  end
end

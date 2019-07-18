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
      model.megakassa_uid = params['uid']

      if params['status'] == 'success'
        model.process
        model.successful!
      else
        model.failed!
      end
    end
  end
end

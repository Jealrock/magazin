module Api::V1
  class PaymentsController < ApiController
    include Pundit

    def create
      run Payments::Create
      render json: {
        target_payment_data: result['model'].build_megakassa_params(ENV['PAYMENT_NOTIFICATION_TARGET_PRICE']),
        all_payment_data: result['model'].build_megakassa_params(ENV['PAYMENT_NOTIFICATION_ALL_PRICE'])
      }
    end

    def update
      run Payments::Update
      result_show_create(result, serializer: ::Api::V1::PaymentSerializer)
    end

    def success
      payment = Payment.find_by(megakassa_order_id: params['order_id'])
      redirect_to payment ? '/' : payment.redirect_path
    end

    def failure
      payment = Payment.find_by(megakassa_order_id: params['order_id'])
      redirect_to payment ? '/' : payment.redirect_path
    end

    def handler
      render(plain: 'error') && return unless Megakassa.valid?(params)

      run Payment::Handle
      render(plain: 'ok') && return
    end
  end
end

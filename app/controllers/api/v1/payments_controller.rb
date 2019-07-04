module Api::V1
  class PaymentsController < ApiController
    include Pundit

    def create
      @payment = current_user.payments.new(payment_params)
      if @payment.save
        render json: { status: 'ok' }
      else
        render json: { status: 'fail' }
      end
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

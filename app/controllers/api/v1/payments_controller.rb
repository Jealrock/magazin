module Api::V1
  class PaymentsController < ApiController
    include Pundit
    before_action :authenticate_user!, only: [:create, :update]

    def create
      run Payments::Create
      render json: result['model'].megakassa_params
    end

    def update
      run Payments::Update
      render json: { status: 'ok' }
    end

    def success
      payment = Payment.find_by(id: params['MERCHANT_ORDER_ID'])
      redirect_to payment ? payment.successfull_redirect_path : '/'
    end

    def failure
      payment = Payment.find_by(id: params['MERCHANT_ORDER_ID'])
      redirect_to payment ? payment.failed_redirect_path : '/'
    end

    def handle
      render(plain: 'error') && return unless ::Freekassa.valid?(params)

      run Payments::Handle
      render(plain: 'yes') && return
    end
  end
end

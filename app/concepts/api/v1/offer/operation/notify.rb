module Api::V1::Offer
  class Notify < ApplicationOperation
    step Model(Offer, :find_by)
    failure :not_found!, fail_fast: true
    step Policy::Pundit(OfferPolicy, :send_notifcation?)
    failure :authorization_error!
    step :create_payment!

    # private

    # def create_payment!(_options, model:, **)
    #   currency = (locale == 'ru' ? 'RUB' : 'USD')
    #   Megakassa.pay_redirect(
    #     ENV['NOTIFICATION_PRICE'],
    #     'RUB', model.id, model.payment_system_id,
    #     model.user.email, model.phone.to_s, '', ENV["MEGAKASSA_SIGNATURE"], locale)
    #   )
    # end
  end
end

module Api::V1::Offer
  class Notify < ApplicationOperation
    step Model(Offer, :find_by)
    failure :not_found!, fail_fast: true
    step Policy::Pundit(OfferPolicy, :send_notifcation?)
    failure :authorization_error!
    step :require_subscriptions!
    step :send_notifications!

    private

    def require_subscriptions!(options, params:, **)
      subscriptions = Subscription.all

      subscriptions = subscriptions.by_user_category_subscriptions(params[:categories]).distinct unless params[:categories].empty?

      options['subscriptions'] = subscriptions
    end

    def send_notifications!(options, model:, **)
      subscriptions = options['subscriptions']

      subscriptions.each do |sub|
        if ENV['SYNC_JOBS']
          SendNotificationJob.perform_now(sub, build_message(model))
        else
          SendNotificationJob.perform_later(sub, build_message(model))
        end
      end

      true
    end

    def build_message(offer)
      JSON.generate(
        title: 'Новое объявление',
        body: offer.title,
        icon: offer.photos.first.file.url(:thumb),
        offer_id: offer.id
      )
    end
  end
end

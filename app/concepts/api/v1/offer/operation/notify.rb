module Api::V1::Offer
  class Notify < ApplicationOperation
    step Model(Offer, :find_by)
    failure :not_found!, fail_fast: true
    step Policy::Pundit(OfferPolicy, :send_notifcation?)
    failure :authorization_error!
    step :send_notifications!

    private

    def send_notifications!(_options, model:, **)
      Subscription.all.each do |sub|
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

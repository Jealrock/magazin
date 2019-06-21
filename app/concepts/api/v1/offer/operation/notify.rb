module Api::V1::Offer
  class Notify < ApplicationOperation
    step Model(Offer, :find_by)
    failure :not_found!, fail_fast: true
    step Policy::Pundit(OfferPolicy, :send_notifcation?)
    failure :authorization_error!
    step :require_subscriptions!
    step :send_notifications!
    step :get_offer!

    private

    def require_subscriptions!(options, params:, **)
      subscriptions = Subscription.all

      subscriptions = filter_by_categories(subscriptions, params[:categories]) unless params[:categories].empty?

      options['model'] = subscriptions
    end

    def filter_by_categories(subscriptions, categories)
      subscriptions.joins(user: [:category_subscriptions]).by_user_category_subscriptions(categories).distinct
    end

    def send_notifications!(_options, model:, params:, **)
      offer = Offer.find(params[:id])
      subscriptions = model

      subscriptions.each do |sub|
        if ENV['SYNC_JOBS']
          SendNotificationJob.perform_now(sub, build_message(offer))
        else
          SendNotificationJob.perform_later(sub, build_message(offer))
        end
      end

      true
    end

    def get_offer!(options, params:, **)
      options['model'] = Offer.find(params[:id])
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

class NotifyUsers
  include Callable

  def initialize(offer, params = {})
    @params = params || {}
    @offer = offer
    @message = JSON.generate(
      title: 'Новое объявление',
      body: offer.title,
      icon: offer.photos.first&.file&.url(:thumb),
      offer_id: offer.id
    )
  end

  def call
    subscriptions.map { |sub| send_notification(sub) }
  end

  private

  attr_reader :params, :offer, :message

  def subscriptions
    return @subscriptions if @subscriptions

    @subscriptions = Subscription.all

    unless params['categories'].blank?
      @subscriptions = @subscriptions.by_user_category_subscriptions(params['categories']).distinct
    end

    @subscriptions = @subscriptions.by_user_cities(params['cities']).distinct unless params['cities'].blank?

    @subscriptions
  end

  def send_notification(subscription)
    if ENV['SYNC_JOBS']
      SendNotificationJob.perform_now(subscription, message)
      OfferMailer.with(user: subscription.user, offer: offer).notify.deliver_now
    else
      SendNotificationJob.perform_later(subscription, message)
      OfferMailer.with(user: subscription.user, offer: offer).notify.deliver_later
    end
  end
end

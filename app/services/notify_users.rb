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
    users.map { |user| send_page_notification(user) }
  end

  private

  attr_reader :params, :offer, :message

  def users
    return @users if @users

    @users = User.all

    @users = @users.by_category_subscriptions(params['categories']).distinct unless params['categories'].blank?

    @users = @users.by_cities(params['cities']).distinct unless params['cities'].blank?

    @users
  end

  def subscriptions
    Subscription.where(user_id: users.pluck(:id))
  end

  def send_page_notification(user)
    if ENV['SYNC_JOBS']
      SendPageNotificationJob.perform_now(user, message)
      OfferMailer.with(user: user, offer: offer).notify.deliver_now
    else
      SendPageNotificationJob.perform_later(user, message)
      OfferMailer.with(user: user, offer: offer).notify.deliver_later
    end
  end

  def send_notification(subscription)
    if ENV['SYNC_JOBS']
      SendNotificationJob.perform_now(subscription, message)
    else
      SendNotificationJob.perform_later(subscription, message)
    end
  end
end

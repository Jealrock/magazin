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
    users.map { |user| send_page_notification(user) }
    subscriptions.map { |sub| send_notification(sub) }
  end

  private

  attr_reader :params, :offer, :message

  def users
    return @users if @users

    @users = User.all

    unless params['categories'].blank?
      @users = @users.by_category_subscriptions(params['categories']).distinct
    end

    unless params['cities'].blank?
      @users = @users.by_cities(params['cities']).distinct
    end

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

class SendPageNotificationJob < ApplicationJob
  def perform(subscription, message)
    user_id = subscription.user.id
    ActionCable.server.broadcast(
      "user_#{user_id}_page_notifications_channel",
      message
    )
  end
end

class SendPageNotificationJob < ApplicationJob
  queue_as :default

  def perform(user, message)
    ActionCable.server.broadcast(
      "user_#{user.id}_page_notifications_channel",
      message
    )
  end
end

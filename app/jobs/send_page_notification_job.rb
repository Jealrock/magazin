class SendPageNotificationJob < ApplicationJob
  def perform
    ActionCable.server.broadcast "page_notifications_channel", message: "kek"
  end
end

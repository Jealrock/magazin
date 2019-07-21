class PageNotificationsChannel < ApplicationCable::Channel
  def subscribed
    authorize!
    stream_from "user_#{current_user.id}_page_notifications_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

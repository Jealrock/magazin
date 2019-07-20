class PageNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_#{params[:user_id]}_page_notifications_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

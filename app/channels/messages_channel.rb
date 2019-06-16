class MessagesChannel < ApplicationCable::Channel
  def subscribed
    authorize!
    stream_from "#{current_user.id}_messages_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

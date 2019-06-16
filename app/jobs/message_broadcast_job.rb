class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message_id)
    message = Message.find(message_id)
    ActionCable.server.broadcast "user#{message.from_user_id}", data: message.to_json
    ActionCable.server.broadcast "user#{message.to_user_id}", data: message.to_json
  rescue StandardError
    nil
  end
end

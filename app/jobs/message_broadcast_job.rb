class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message_id)
    message = Message.find(message_id)
    ActionCable.server.broadcast "#{message.to_user_id}_messages_channel",
                                 Api::V1::MessageSerializer.new(message).serialized_json
  rescue StandardError
    nil
  end
end

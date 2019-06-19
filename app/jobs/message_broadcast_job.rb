class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message_id)
    message = Message.includes(:from_user, :to_user).find(message_id)
    ActionCable.server.broadcast "#{message.to_user_id}_messages_channel",
                                 Api::V1::MessageWithUsersDataSerializer.new(message).serialized_json
  rescue StandardError
    nil
  end
end

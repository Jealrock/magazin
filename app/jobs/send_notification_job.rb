class SendNotificationJob < ApplicationJob
  def perform(subscription, message)
    Webpush.payload_send(
      message: message,
      endpoint: subscription.endpoint,
      p256dh: subscription.p256dh,
      auth: subscription.auth,
      api_key: ENV['FCM_SERVER_KEY']
    )
  rescue StandardError => e
    p "[#{Time.zone.now.to_formatted_s(:short)}] SendNotificationError: #{e}"
    subscription.destroy
  end
end

class Api::V1::SubscriptionSerializer < Api::V1::ApplicationSerializer
  attributes :id, :endpoint, :p256dh, :auth
end

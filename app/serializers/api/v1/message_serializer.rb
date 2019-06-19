class Api::V1::MessageSerializer < Api::V1::ApplicationSerializer
  attributes :id, :text, :created_at, :from_user_id, :to_user_id
end

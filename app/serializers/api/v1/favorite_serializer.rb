class Api::V1::FavoriteSerializer < Api::V1::ApplicationSerializer
  attributes :id, :offer_id, :user_id, :created_at, :updated_at
end

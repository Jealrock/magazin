class Api::V1::OfferSerializer < Api::V1::ApplicationSerializer
  attributes :id,
             :user_id,
             :closed,
             :type,
             :price,
             :exchange_item,
             :title,
             :description,
             :location,
             :email,
             :phone_number,
             :created_at,
             :updated_at
end

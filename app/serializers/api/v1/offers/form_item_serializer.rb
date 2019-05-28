module Api::V1
  module Offers
    class FormItemSerializer < Api::V1::ApplicationSerializer
      attributes :id, :user_id, :closed, :type, :price, :exchange_item, :title, :description, :location,
                 :email, :phone_number, :created_at, :updated_at

      belongs_to :user, serializer: ::Api::V1::Users::RelationSerializer
    end
  end
end

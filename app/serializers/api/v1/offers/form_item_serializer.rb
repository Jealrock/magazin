module Api::V1
  module Offers
    class FormItemSerializer < Api::V1::ApplicationSerializer
      attributes :id, :user_id, :closed, :type, :price, :exchange_item, :title, :description, :address,
                 :phone_number, :created_at, :updated_at

      attribute :photos do |object|
        object.photos.map(&:file)
      end

      attribute :user do |object|
        {
          city: object.user.city,
          name: object.user.name,
          photo: object.user.photo,
          created_at: object.user.created_at
        }
      end
    end
  end
end

module Api::V1
  module Offers
    class ListItemSerializer < Api::V1::ApplicationSerializer
      attributes :id, :type, :price, :title, :created_at

      attribute :photos do |object|
        object.photos.map(&:file)
      end
    end
  end
end

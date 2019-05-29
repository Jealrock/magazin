module Api::V1
  module Offers
    class ListItemSerializer < Api::V1::ApplicationSerializer
      attributes :id, :type, :price, :title, :created_at
    end
  end
end

module Api::V1
  module Users
    class RelationSerializer < Api::V1::ApplicationSerializer
      attributes :city, :name, :photo, :created_at
    end
  end
end

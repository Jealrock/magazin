class Api::V1::CategorySerializer < Api::V1::ApplicationSerializer
  attributes :id, :parent_id, :title
end

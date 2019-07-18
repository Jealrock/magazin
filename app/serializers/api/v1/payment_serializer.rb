class Api::V1::PaymentSerializer < Api::V1::ApplicationSerializer
  attributes :name, :amount, :price, :status, :params, :payable_entity_type, :payable_entity_id
end

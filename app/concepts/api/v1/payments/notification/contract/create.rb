require 'reform'
require 'reform/form/dry'
require 'dry-validation'

module Payments::Notification::Contract
  class Create < Reform::Form
    include Dry

    property :payable_entity_id
    property :payable_entity_type
    property :price

    validation do
      required(:payable_entity_id).filled
      required(:payable_entity_type).filled
      required(:price).filled
    end
  end
end

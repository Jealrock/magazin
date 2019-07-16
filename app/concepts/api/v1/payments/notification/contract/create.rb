require 'reform'
require 'reform/form/dry'
require 'dry-validation'

module Payments::Notification::Contract
  class Create < Reform::Form
    include Dry

    property :payable_entity_id
    property :payable_entity_type
  end
end

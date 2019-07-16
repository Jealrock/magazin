require 'reform'
require 'reform/form/dry'
require 'dry-validation'

module Payments::Notification::Contract
  class Update < Reform::Form
    include Dry

    property :params do
      property :cities
      property :categories
    end
  end
end

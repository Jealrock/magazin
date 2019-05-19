require 'reform'
require 'reform/form/dry'
require 'dry-validation'

module Offer::Contract
  class Create < Reform::Form
    include Dry

    property :name

    validation do
      required(:name).filled
    end
  end
end

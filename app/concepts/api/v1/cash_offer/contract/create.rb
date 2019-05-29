require 'reform'
require 'reform/form/dry'
require 'dry-validation'

module CashOffer::Contract
  class Create < ::Offer::Contract::Create
    property :price

    validation do
      required(:price).filled
    end
  end
end

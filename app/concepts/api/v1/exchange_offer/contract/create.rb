require 'reform'
require 'reform/form/dry'
require 'dry-validation'

module ExchangeOffer::Contract
  class Create < ::Offer::Contract::Create
    property :exchange_item
  end
end

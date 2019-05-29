require 'reform'
require 'reform/form/dry'
require 'dry-validation'
require "#{Rails.root}/app/concepts/api/v1/offer/contract/create"

module ExchangeOffer::Contract
  class Create < ::Offer::Contract::Create
    property :exchange_item
  end
end

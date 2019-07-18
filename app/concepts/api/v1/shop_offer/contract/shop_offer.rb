require 'reform'
require 'reform/form/dry'
require 'dry-validation'
require "#{Rails.root}/app/concepts/api/v1/offer/contract/create"

module ShopOffer::Contract
  class Create < ::Offer::Contract::Create
    property :price

    validation do
      required(:price).filled
    end
  end
end

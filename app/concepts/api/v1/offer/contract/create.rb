require 'reform'
require 'reform/form/dry'
require 'dry-validation'

module Offer::Contract
  class Create < Reform::Form
    include Dry

    property :type
    property :title
    property :price
    property :exchange_item
    property :description
    property :location
    property :email
    property :phone_number

    validation do
      required(:type).filled
      required(:title).filled
      required(:description).filled(min_size?: 10)
      required(:location).filled
      required(:email).filled
      required(:phone_number).filled
    end
  end
end

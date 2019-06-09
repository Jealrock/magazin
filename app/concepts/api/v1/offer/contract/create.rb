require 'reform'
require 'reform/form/dry'
require 'dry-validation'

module Offer::Contract
  class Create < Reform::Form
    include Dry

    property :type
    property :category_id
    property :title
    property :description
    property :address
    property :phone_number

    validation do
      required(:type).filled
      required(:category_id).filled
      required(:title).filled
      required(:description).filled(min_size?: 10)
      required(:address).filled
      required(:phone_number).filled
    end
  end
end

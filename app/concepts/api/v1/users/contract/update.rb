require 'reform'
require 'reform/form/dry'
require 'dry-validation'

module User::Contract
  class Update < Reform::Form
    include Dry

    property :photo
    property :name
    property :city
    property :email
    property :phone_number

    validation do
      required(:email).filled
    end
  end
end

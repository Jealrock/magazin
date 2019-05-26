require 'reform'
require 'reform/form/dry'
require 'dry-validation'

module Offer::Contract
  class Create < Reform::Form
    include Dry

    property :title
    property :description
    property :acquireMethod
    property :price
    property :youtube_video_url
    property :address
    property :email
    property :phone_number
    property :is_comments_enable
    property :is_phone_number_visible

    validation do
      required(:title).filled
      required(:description).filled
    end
  end
end

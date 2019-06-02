module Api::V1::Geolocation
  class Address < ApplicationOperation
    step :find_address!
    failure :not_found!, fail_fast: true

    private

    def find_address!(options, params:, **)
      options['model'] = Geocoder.search(params[:address])
    end
  end
end

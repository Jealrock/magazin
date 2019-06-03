module Api::V1::Geolocation
  class Index < ApplicationOperation
    step :find_address!
    failure :not_found!, fail_fast: true

    private

    def find_address!(options, params:, **)
      options['model'] = Geocoder.search(params[:q])
    end
  end
end

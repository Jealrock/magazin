module Api::V1
  class GeolocationsController < ApiController
    def index
      run Geolocation::Index
      render json: { data: serialize_locations(result['model']) }
    end

    private

    # id is mandatory field for fast_jsonapi
    def serialize_locations(locations)
      locations.map do |location|
        {
          city: location.city,
          address: location.address
        }
      end
    end
  end
end

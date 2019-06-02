module Api::V1
  class GeolocationsController < ApiController
    def address
      run Geolocation::Address
      render json: {
        data: result['model'].map(&:display_name)
      }
    end

    def city
      run Geolocation::City
      result_show_create(result, serializer: ::Api::V1::Offers::FormItemSerializer)
    end
  end
end

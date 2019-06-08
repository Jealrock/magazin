module Api::V1
  class OffersController < ApiController
    include Pundit
    before_action :authenticate_user!, except: [:index, :show]

    def index
      run Offer::Index
      result_index(result, serializer: ::Api::V1::Offers::ListItemSerializer)
    end

    def show
      run Offer::Show
      result_show_create(result, serializer: ::Api::V1::Offers::FormItemSerializer)
    end

    def create
      run Offer::Create
      result_show_create(result, serializer: ::Api::V1::Offers::FormItemSerializer)
    end

    def close
      run Offer::Close
      result_show_create(result, serializer: ::Api::V1::Offers::FormItemSerializer)
    end

    def notify
      run Offer::Notify
      result_show_create(result, serializer: ::Api::V1::Offers::FormItemSerializer)
    end
  end
end

module Api::V1
  class OffersController < ApiController
    include Pundit
    before_action :authenticate_user!

    def index
      run Offer::Index
      result_index(result, serializer: ::Api::V1::OfferSerializer)
    end

    def show
      run Offer::Show
      result_show_create(result, serializer: ::Api::V1::OfferSerializer)
    end

    def create
      run Offer::Create
      result_show_create(result, serializer: ::Api::V1::OfferSerializer)
    end
  end
end

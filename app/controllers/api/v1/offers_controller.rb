module Api::V1
  require_dependency Rails.root.join('app', 'concepts', 'api', 'v1', 'offer', 'contract', 'create')

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
  end
end

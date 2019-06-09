module Api::V1
  class FavoritesController < ApiController
    include Pundit
    before_action :authenticate_user!, only: %i[create destroy]

    def index
      run Favorite::Index
      result_index(result, serializer: ::Api::V1::Offers::ListItemSerializer)
    end

    def create
      run Favorite::Create
      result_show_create(result, serializer: ::Api::V1::Offers::ListItemSerializer)
    end

    def destroy
      run Favorite::Destroy
      result_show_create(result, serializer: ::Api::V1::Offers::ListItemSerializer)
    end
  end
end

module Api::V1
  class CategorySubscriptionsController < ApiController
    include Pundit
    before_action :authenticate_user!

    def index
      run CategorySubscription::Index
      result_index(result, serializer: ::Api::V1::CategorySerializer)
    end

    def create
      run CategorySubscription::Create
      result_show_create(result, serializer: ::Api::V1::CategorySerializer)
    end

    def destroy
      run CategorySubscription::Destroy
      result_show_create(result, serializer: ::Api::V1::CategorySerializer)
    end
  end
end

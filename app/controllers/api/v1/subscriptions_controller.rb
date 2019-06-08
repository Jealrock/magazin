module Api::V1
  class SubscriptionsController < ApiController
    include Pundit
    before_action :authenticate_user!

    def create
      run Subscription::Create
      result_show_create(result, serializer: ::Api::V1::SubscriptionSerializer)
    end
  end
end

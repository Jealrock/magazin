module Api::V1::Subscription
  class Create < ApplicationOperation
    step Policy::Pundit(SubscriptionPolicy, :create?)
    failure :authorization_error!, fail_fast: true
    step :create_subscription!

    private

    def create_subscription!(options, current_user:, params:, **)
      options['model'] = Subscription.create!(
        endpoint: params[:endpoint],
        p256dh: params[:keys][:p256dh],
        auth: params[:keys][:auth],
        user_id: current_user.id
      )
    end
  end
end

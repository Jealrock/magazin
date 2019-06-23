module Api::V1::CategorySubscription
  class Create < ApplicationOperation
    step Policy::Pundit(CategorySubscriptionPolicy, :create?)
    failure :authorization_error!, fail_test: true
    step :create_category_subscription!

    private

    def create_category_subscription!(options, current_user:, params:, **)
      subscription = CategorySubscription.create!(user_id: current_user.id,
                                                  category_id: params['category_id'])

      options['model'] = subscription.category
    end
  end
end

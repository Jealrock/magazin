module Api::V1::CategorySubscription
  class Destroy < ApplicationOperation
    step :find!
    failure :not_found!, fail_test: true
    step Policy::Pundit(CategorySubscriptionPolicy, :destroy?)
    failure :authorization_error, fail_test: true
    step :destroy!

    private

    def find!(options, params:, current_user:, **)
      options['model'] = current_user.category_subscriptions.find_by(category_id: params['id'])
    end

    def destroy!(options, model:, **)
      model.destroy!

      options['model'] = model.category
    end
  end
end

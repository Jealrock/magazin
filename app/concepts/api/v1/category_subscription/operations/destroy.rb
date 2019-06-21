module Api::V1::CategorySubscription
  class Destroy < ApplicationOperation
    step :find!
    failure :not_found!, fail_test: true
    step :destroy!
    step :get_category!

    private

    def find!(options, params:, current_user:, **)
      options['model'] = current_user.category_subscriptions.find_by(category_id: params['id'])
    end

    def destroy!(_options, model:, **)
      model.destroy!
      model
    end

    def get_category!(options, model:, **)
      category = model.category
      options['model'] = category
    end
  end
end

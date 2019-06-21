module Api::V1::CategorySubscription
  class Index < ApplicationOperation
    step :model!

    private

    def model!(options, current_user:, **)
      options['model'] = current_user.subscribed_categories.order(created_at: :desc)
    end
  end
end

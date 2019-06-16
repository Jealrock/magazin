module Api::V1::MessageThread
  class Index < ApplicationOperation
    step Policy::Pundit(MessagePolicy, :index?)
    failure :authorization_error!
    step :model!

    def model!(options, current_user:, **)
      options['model'] = current_user.messages.includes(:from_user, :to_user)
                                     .group(:from_user_id, :to_user_id)
                                     .limit(1)
                                     .uniq
    end
  end
end

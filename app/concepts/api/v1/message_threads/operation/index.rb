module Api::V1::MessageThread
  class Index < ApplicationOperation
    step Policy::Pundit(MessagePolicy, :index?)
    failure :authorization_error!
    step :model!

    def model!(options, current_user:, **)
      options['model'] = Message.includes(:from_user, :to_user)
                                .recent_messages_with(current_user.id)
                                .distinct
    end
  end
end

module Api::V1::Message
  class Index < ApplicationOperation
    step Policy::Pundit(MessagePolicy, :index?)
    failure :authorization_error!
    step :model!

    def model!(options, current_user:, params:, **)
      options['model'] = current_user.messages.with(params[:user_id]).ordered_by_time
    end
  end
end

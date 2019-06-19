module Api::V1::Message
  class Index < ApplicationOperation
    step Policy::Pundit(MessagePolicy, :index?)
    failure :authorization_error!
    step :model!

    def model!(options, current_user:, params:, **)
      options['model'] = if params[:with_user_id] == current_user.id
                           # check this later
                           Message.where(from_user_id: params[:with_user_id], to_user_id: params[:with_user_id])
                                  .ordered_by_time
                                  .distinct
                         else
                           current_user.messages.with(params[:with_user_id]).ordered_by_time.distinct
                         end
    end
  end
end

module Api::V1::Message
  class Create < ApplicationOperation
    step Policy::Pundit(MessagePolicy, :create?)
    failure :authorization_error!, fail_fast: true
    step Model(Message, :new)
    step :add_from_user_id!
    step Contract::Build(constant: Message::Contract::Create)
    step Contract::Validate()
    failure :invalid!
    step Contract::Persist()
    step :broadcast_to_user!

    private

    def add_from_user_id!(_options, current_user:, model:, **)
      model.from_user_id = current_user.id
    end

    def broadcast_to_user!(_options, model:, **)
      if ENV['SYNC_JOBS']
        MessageBroadcastJob.perform_now(model.id)
      else
        MessageBroadcastJob.perform_later(model.id)
      end

      model
    end
  end
end

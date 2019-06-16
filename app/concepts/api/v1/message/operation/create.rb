module Api::V1::Message
  class Create < ApplicationOperation
    step Policy::Pundit(MessagePolicy, :create?)
    failure :authorization_error!, fail_fast: true
    step Model(Message, :new)
    step :add_from_user_id!
    step Contract::Build(builder: :contract_builder!)
    step Contract::Validate()
    failure :invalid!
    step Contract::Persist()
  end
end

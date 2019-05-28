module Api::V1::User
  class Update < ApplicationOperation
    step Model(User, :find_by)
    step Policy::Pundit(Api::V1::UserPolicy, :update?)
    failure :authorization_error!, fail_fast: true
    step Contract::Build(constant: User::Contract::Update)
    step Contract::Validate()
    failure :invalid!
    step Contract::Persist()
  end
end

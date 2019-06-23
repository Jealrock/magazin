module Api::V1::User
  class Show < ApplicationOperation
    step Model(User, :find_by)
    failure :not_found!, fail_fast: true
    step Policy::Pundit(UserPolicy, :show?)
    failure :authorization_error!
  end
end

class Api::ApiController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  rescue_from ActionController::ParameterMissing, with: :bad_request
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def bad_request(message = 'Bad request')
    render json: { errors: [message] }, status: :bad_request
  end

  def forbidden(message = 'Forbidden')
    render json: { errors: [message] }, status: :forbidden
  end

  def not_authorized(message = 'Not authorized')
    render json: { errors: [message] }, status: :unauthorized
  end

  def not_found(message = 'Not found')
    render json: { errors: [message] }, status: :not_found
  end

  def unprocessable_entity(exception)
    render json: { errors: exception.record.errors.full_messages },
           status: :unprocessable_entity
  end
end

class Api::V1::ApiController < ApplicationController
  MAX_PER_PAGE = 300
  include DeviseTokenAuth::Concerns::SetUserByToken
  rescue_from ActionController::ParameterMissing, with: :bad_request
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def destroy_session
    request.session_options[:skip] = true
  end

  private

  def result_index(result, serializer_options)
    render_error(result) && return unless result.success?

    collection = apply_scopes(result['model']).page(page).per(per_page)
    render json: serialize_resource(collection, serializer_options).merge(
      meta: {
        pagination: {
          page: collection.current_page,
          per_page: collection.limit_value,
          pages: collection.total_pages,
          results_count: collection.size,
          total_count: collection.total_count
        }
      }
    ), status: 200
  end

  def result_show_create(result, serializer_options)
    render_error(result) && return unless result.success?

    render json: serialize_resource(result['model'], serializer_options), status: 200
  end

  def result_delete(result, *)
    render_error(result) && return unless result.success?

    render json: {}, status: 204
  end

  def per_page
    current_per_page = params[:per_page] ? params[:per_page].to_i : MAX_PER_PAGE
    raise "Max per page limit is #{MAX_PER_PAGE}" if current_per_page > MAX_PER_PAGE

    current_per_page
  end

  def page
    params[:page] || 1
  end

  def serialize_resource(resource, serializer_options)
    serializer_options[:serializer].new(resource, serializer_options).serializable_hash
  end

  def render_error(failed_result)
    render json: {
      error_message: failed_result['error'],
      errors: failed_result['contract.default']&.errors&.messages || {}
    }, status: failed_result['error.status']
  end

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

  def _run_options(options)
    options.merge('current_user' => current_user)
  end
end

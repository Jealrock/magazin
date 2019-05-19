class ApplicationOperation < Trailblazer::Operation
  private

  def authorization_error!(options, *)
    options['error'] = 'Unauthorized'
    options['error.status'] = 401
  end

  def not_found!(options, *)
    options['error'] = 'Not found'
    options['error.status'] = 404
  end

  def invalid!(options, *)
    options['error'] = 'Validation failed'
    options['error.status'] = 422
  end

  def add_user_id!(_options, current_user:, model:, **)
    model.user_id = current_user.id
  end
end

module Api::V1
  class UsersController < ApiController
    include Pundit
    before_action :authenticate_user!

    def update
      run User::Update
      result_show_create(result, serializer: ::Api::V1::UserSerializer)
    end
  end
end

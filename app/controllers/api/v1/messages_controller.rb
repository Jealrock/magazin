module Api::V1
  class MessagesController < ApiController
    include Pundit
    before_action :authenticate_user!

    def index
      run Message::Index
      result_index(result, serializer: ::Api::V1::MessageSerializer)
    end

    def create
      run Message::Create
      result_show_create(result, serializer: ::Api::V1::MessageSerializer)
    end
  end
end

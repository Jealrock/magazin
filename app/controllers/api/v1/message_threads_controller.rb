module Api::V1
  class MessageThreadsController < ApiController
    include Pundit
    before_action :authenticate_user!

    def index
      run MessageThread::Index
      result_index(result, serializer: ::Api::V1::MessageSerializer)
    end
  end
end

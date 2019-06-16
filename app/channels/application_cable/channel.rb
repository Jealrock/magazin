module ApplicationCable
  class Channel < ActionCable::Channel::Base
    attr_accessor :current_user

    protected

    def authorize!
      self.current_user = User.find_by_uid(auth_params['uid'])
      if !current_user ||
         !current_user.valid_token?(auth_params['access-token'], auth_params['client'])
        reject
      end
    end

    def auth_params
      params['auth']
    end
  end
end

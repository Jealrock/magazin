class Api::V1::UserSerializer < Api::V1::ApplicationSerializer
  attributes :id, :city, :allow_password_change, :email, :name, :provider, :photo, :uid
end

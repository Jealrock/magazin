class Api::V1::UserSerializer < Api::V1::ApplicationSerializer
  attributes :id, :city, :address, :allow_password_change, :email, :name, :provider, :photo, :uid, :phone_number
end

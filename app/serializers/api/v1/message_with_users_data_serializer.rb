class Api::V1::MessageWithUsersDataSerializer < Api::V1::MessageSerializer
  attribute :from_user do |object|
    {
      id: object.from_user.id,
      name: object.from_user.name,
      photo: object.from_user.photo
    }
  end

  attribute :to_user do |object|
    {
      id: object.to_user.id,
      name: object.to_user.name,
      photo: object.to_user.photo
    }
  end
end

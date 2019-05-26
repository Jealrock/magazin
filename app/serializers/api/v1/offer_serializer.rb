class Api::V1::OfferSerializer < Api::V1::ApplicationSerializer
  attributes :id,
    :title,
    :description,
    :acquireMethod,
    :price,
    :youtube_video_url,
    :address,
    :email,
    :phone_number,
    :is_comments_enable,
    :is_phone_number_visible,
    :created_at,
    :updated_at
end

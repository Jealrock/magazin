class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  if Rails.env.development? || Rails.env.test?
    storage :file
  else
    storage :fog
  end

  version :thumb do
    process resize_to_limit: [150, 150]
  end

  def asset_host
    ActionController::Base.asset_host
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  def extension_whitelist
    %w[jpg jpeg gif png svg]
  end
end

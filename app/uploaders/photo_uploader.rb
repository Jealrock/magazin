class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  if ENV['STORAGE_TYPE'].blank? || ENV['STORAGE_TYPE'] == 'local'
    storage :file
  else
    storage :fog
  end

  version :thumb do
    process resize_to_limit: [400, 400]
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

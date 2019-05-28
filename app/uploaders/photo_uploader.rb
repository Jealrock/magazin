class PhotoUploader < CarrierWave::Uploader::Base
  storage :file

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

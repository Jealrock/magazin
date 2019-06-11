CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider              => 'AWS',
    :aws_access_key_id     => ENV['S3_ACCESS_KEY'],
    :aws_secret_access_key => ENV['S3_SECRET_KEY'],
    :region                => ENV['S3_REGION'],
    :endpoint              => 'https://s3.amazonaws.com'
  }
  config.fog_directory =  ENV['S3_BUCKET']
  config.fog_public = false
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
end

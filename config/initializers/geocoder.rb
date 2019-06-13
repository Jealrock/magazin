if Rails.env.development?
  Geocoder.configure(
    language: :ru,
  )
else
  Geocoder.configure(
    lookup: :yandex,
    ip_lookup: :ipinfo_io,
    language: :ru,
    timeout: 5,
    units: :km,
    cache: Redis.new,
    cache_prefix: 'geocoder:' 
  )
end

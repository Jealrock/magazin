source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.5'

# ENV
gem 'dotenv-rails'

gem 'rails', '~> 5.2.3'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'normalize-rails'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'
gem 'fast_jsonapi'
gem 'trailblazer'
gem 'trailblazer-rails'
gem 'reform-rails'
gem 'dry-types', '0.12.2'
gem 'dry-validation', '0.11.1'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 3.5.5'
gem 'webpush', github: 'zaru/webpush', branch: 'master'

# Background jobs
gem 'sidekiq'
gem 'sidekiq-scheduler'

# Pagination
gem 'kaminari'

# Auth
gem 'devise_token_auth'
gem 'pundit'

# automatic scopes
gem 'has_scope'

# Geolocation solution
gem 'geocoder'

# File upload
gem 'carrierwave'
gem 'fog'
gem 'fog-aws'
gem 'mini_magick'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'pry-rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Codestyle
  gem 'rubocop', require: false
  gem 'overcommit'
  # Mailer
  gem 'letter_opener'

  # Capistrano deployment scripts 
  gem 'capistrano',           require: false
  gem 'rvm1-capistrano3',     require: false
  gem 'capistrano-rails',     require: false
  gem 'capistrano-bundler',   require: false
  gem 'capistrano-yarn',      require: false
end

group :test do
  gem 'database_cleaner'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

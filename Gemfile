source 'https://rubygems.org'

ruby '2.5.3'

# .env
gem 'dotenv', '~> 2.6'

# Sinatra
gem 'sinatra', '~> 2.0.5'
gem 'async_sinatra', '~> 1.3'

# Curb
gem 'curb', '~> 0.9.8'

# ActiveSupport
gem 'activesupport', '~> 5.2', require: %w[
  active_support/dependencies
]

# Heroku
gem 'sqreen'

group :development, :test do
  gem 'sinatra-reloader', '~> 1.0'
  gem 'rack-test', require: 'rack/test'
  gem 'rspec'
end


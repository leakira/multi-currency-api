require 'bundler/setup'
require 'sinatra/base'

# Load environment variables
require 'dotenv'
Dotenv.load '.env', ".env.#{Sinatra::Application.environment}"

# Load dependencies
Bundler.setup :default, Sinatra::Application.environment
Bundler.require

# Set autoloading directories
ActiveSupport::Dependencies.autoload_paths += %w[
  app/plugins
]

# Load initializers
Dir['./app/*.rb'].each &method(:require) # Load first from app directory
Dir['./app/**/*.rb'].each &method(:require)
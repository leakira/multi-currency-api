require 'rack/test'
require 'rspec'

require_relative '../autoloader'
ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods

  def app
    App
  end
end

RSpec.configure do |c|
  c.include RSpecMixin
  c.include Rack::Test::Methods
end
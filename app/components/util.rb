APP_PATH = "#{File.dirname(__FILE__)}/.."
ASSET_PATH = "#{APP_PATH}/assets"

def currency
  @currency ||= begin
    file = File.read "#{ASSET_PATH}/currency.json"
    JSON.parse file
  end
end

def plugins
  @plugins ||= begin
    file = File.read "#{ASSET_PATH}/plugins.json"
    JSON.parse file
  end
end

def development?
  ENV['RACK_ENV'] == 'development'
end

def response_as(type, message: '', data: '')
  {
    success: type == :success ? 1 : 0,
    message: message,
    data:    data,
  }.to_json
end
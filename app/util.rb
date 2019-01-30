def currency
  @currency ||= begin
    file = File.read "#{File.dirname(__FILE__)}/assets/currency.json"
    JSON.parse file
  end
end

def development?
  ENV['RACK_ENV'] == 'development'
end
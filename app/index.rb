require 'sinatra/reloader' if development?

class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    disable :show_exceptions
  end

  before do
    content_type :json
  end

  error do
    redirect '/'
  end

  get '/' do
    response = File.read "#{File.dirname(__FILE__)}/assets/description.json"
    JSON.parse(response).to_json
  end

  get '/currency' do
    currency.to_json
  end

  get '/currency/names' do
    currency.keys.to_json
  end

  # convert/55?from=BRL&to=JPY&use=currency_converter
  # Make conversion
  # - value: value to calculate
  # - ?from: base currency
  # - ?to: target currencies to convert. Optional. Need to pass by comma if has more than one
  # - ?use: use custom plugin. By default use free_currency_converter
  get '/convert/:value' do
    ensure_from_exists!

    response = Engine
      .new(plugin)
      .convert(params[:value], from: params[:from], to: to)

    response.to_json
  end

  private

  def ensure_from_exists!
    return if currency.keys.include? params[:from]
    raise '"from" parameter is mandatory'
  end

  def plugin
    params[:use] || ENV['DEFAULT_PLUGIN']
  end

  def to
    @to ||= begin
      return currency.keys unless params[:to].present?
      params[:to].split(',')
    end
  end
end
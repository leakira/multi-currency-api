require 'sinatra/reloader' if development?
require 'sinatra/cross_origin'

class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    disable :show_exceptions
  end

  configure do
    enable :cross_origin
  end

  before do
    content_type :json
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  not_found do
    status 404
    response_as :error, message: 'Request not found'
  end

  options "*" do
    response.headers['Allow']                        = 'GET'
    response.headers['Access-Control-Allow-Headers'] = 'Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token'
    response.headers['Access-Control-Allow-Origin']  = '*'

    200
  end

  get '/' do
    data_file = File.read "#{ASSET_PATH}/description.json"
    response_as :success, data: JSON.parse(data_file)
  end

  get '/currency' do
    response_as :success, data: currency
  end

  get '/currency/names' do
    response_as :success, data: currency.keys
  end

  get '/plugins' do
    response_as :success, data: plugins
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

    if params.has_key? :text_format
      content_type :text

      text = []
      response.each { |_,data| text << "#{data['currencySymbol']} #{data['value'].round(2)} (#{data['id']})" }
      text.join("\n")
    else
      if response[:error].present?
        response_as :error, message: response[:error]
      else
        response_as :success, data: response
      end
    end
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
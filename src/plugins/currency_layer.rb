class CurrencyLayer < Plugin
  class << self
    def api
      'http://apilayer.net/api'
    end

    def token
      ENV['CURRENCY_LAYER_TOKEN']
    end

    def find(value, from, to)
      raw_run value, from, to.join(',')
    end

    # Performance test: 26s
    # Start: 2019-01-30 14:43:20 -0200
    # End: 2019-01-30 14:43:46 -0200
    def raw_run(value, from, to)
      url = "#{api}/live?source=#{from}&currencies=#{to}&format=1&access_key=#{token}"
      pp "Running #{url}" if development?
      req = Curl.get url
      res = JSON.parse req.body_str

      unless res['success']
        raise res['error']['info'] if res.dig('error', 'info')
        return
      end

      to.split(',').each do |to_currency|
        pair = "#{from}#{to_currency}"
        next unless res['quotes'][pair].present?

        conversion_result = value.to_f * res['quotes'][pair].to_f
        @response[to_currency] = currency[to_currency].merge({
          'value' => conversion_result,
        })
      end
    end
  end
end
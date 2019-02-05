class FreeCurrencyConverter < Plugin
  class << self
    def api
      'https://free.currencyconverterapi.com/api/v6'
    end

    # Performance test: 26s
    # Start: 2019-01-30 14:43:20 -0200
    # End: 2019-01-30 14:43:46 -0200
    def raw_run(value, from, to)
      url = "#{api}/convert?q=#{from}_#{to}&compact=ultra"
      pp "Running #{url}" if development?
      req = Curl.get url
      res = JSON.parse req.body_str

      conversion_result = value.to_f * res.values.first.to_f

      @response[to] = currency[to].merge({
        'value' => conversion_result,
      })
    end
  end
end
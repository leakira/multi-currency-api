class Fixer < Plugin
  class << self
    def api
      # Fixer free account not allow https request
      protocol = 'http'
      protocol += 's' unless ENV['FIXER_FREE'] == 1
      "#{protocol}://data.fixer.io/api"
    end

    def token
      ENV['FIXER_TOKEN']
    end

    def find(value, from, to)
      raw_run value, from, to.join(',')
    end

    # Performance test: 26s
    # Start: 2019-01-30 14:43:20 -0200
    # End: 2019-01-30 14:43:46 -0200
    def raw_run(value, from, to)
      url = "#{api}/latest?base=#{from}&symbols=#{to}&format=1&access_key=#{token}"
      pp "Running #{url}" if development?
      req = Curl.get url
      res = JSON.parse req.body_str

      unless res['success']
        raise res['error']['info'] if res.dig('error', 'info')
        raise res['error']['type'] if res.dig('error', 'type')
        return
      end

      to.split(',').each do |to_currency|
        next unless res['rates'][to_currency].present?

        conversion_result = value.to_f * res['rates'][to_currency].to_f
        @response[to_currency] = currency[to_currency].merge({
          'value' => conversion_result,
        })
      end
    end
  end
end
class Plugin
  class << self
    def convert(value, from:, to:)
      pp "Using #{name}" if development?
      @threads = []
      @response = {}
      find value, from, to
      @threads.each(&:join) unless @threads.count == 0 # this waits for all the threads to finish before proceeding
      @response
    end

    def find(value, from, to)
      to.each do |to_currency|
        next unless currency[to_currency].present?
        run(value, from, to_currency)
      end
    end

    # Performance test: 7s
    # 2019-01-30 14:46:09 -0200
    # 2019-01-30 14:46:16 -0200
    def run(value, from, to)
      # This makes all requests to run simultaneous
      @threads << Thread.new { raw_run value, from, to }
    end

    def api
      abstract_error 'api'
    end

    def token
      abstract_error 'token'
    end

    # Performance test: 26s
    # Start: 2019-01-30 14:43:20 -0200
    # End: 2019-01-30 14:43:46 -0200
    def raw_run(value, from, to)
      abstract_error 'raw_run'
    end

    private

    def abstract_error(method)
      raise "Called abstract method: #{method}"
    end
  end
end
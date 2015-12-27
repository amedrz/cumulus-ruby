require 'faraday'
require 'logger'
require 'faraday_middleware'

module Cumulus
  class Client
    attr_accessor :request

    API_URL = 'https://api-cumulus.com'

    def initialize(options={})
      @token = options[:token]
    end

    def request(type, path, params={})
      block = Proc.new do |request|
        request.url path
        request.headers['Authorization'] = "Token #{token}"
        request.headers['Content-Type'] = 'application/json'
      end

      send("#{type}_request", path, params, &block)
    end

    private
    def put_request(path, params={}, &block)
      connection.put do |request|
        yield(request)
        request.body = params.to_json
      end
      .body
    end

    def post_request(path, params={}, &block)
      connection.post do |request|
        yield(request)
        request.body = params.to_json
      end
      .body
    end

    def get_request(path, params={}, &block)
      connection.get do |request|
        yield(request)
        params.each { |key, val| request.params[key] = val }
      end
      .body
    end

    def token
      @token
    end

    def connection
      @connection ||= Faraday.new(url: Cumulus::Client::API_URL) do |b|
        b.adapter Faraday.default_adapter
        b.use FaradayMiddleware::ParseJson
      end
    end
  end
end

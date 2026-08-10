# frozen_string_literal: true

require 'faraday'
require 'json'

module Currents
  class Client
    BASE_URL = 'https://api.currentsapi.services/v1'

    def initialize(api_key)
      raise ArgumentError, 'API key is missing' if api_key.nil? || api_key.strip.empty?

      @api_key = api_key
      @conn = Faraday.new(url: BASE_URL) do |f|
        f.response :json
        f.adapter Faraday.default_adapter
      end
    end

    def search(issue)
      response = @conn.get('search') do |req|
        req.params = {
          keywords: issue,
          language: 'en',
          page_size: 5,
          apiKey: @api_key
        }
      end

      handle_response(response)
    end

    private

    def handle_response(response)
      case response.status
      when 200
        response.body['news'] || []
      when 401
        raise Error, 'Unauthorized: Invalid API key'
      when 429
        raise Error, 'Rate limit exceeded'
      else
        raise Error, "API error: #{response.status}"
      end
    end
  end

  class Error < StandardError; end
end

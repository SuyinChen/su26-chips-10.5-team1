# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Currents::Client do
  describe '#initialize' do
    it 'raises an error without an api key' do
      expect { described_class.new(nil) }.to raise_error(ArgumentError)
    end

    it 'can be created with an api key' do
      expect(described_class.new('test-key')).to be_a(described_class)
    end
  end

  describe '#search' do
    let(:client) { described_class.new('test-key') }
    let(:connection) { client.instance_variable_get(:@conn) }

    it 'returns news articles when the request is successful' do
      articles = [{ 'title' => 'Climate Article' }]
      response = instance_double(Faraday::Response, status: 200,
                                                    body: { 'news' => articles })
      allow(connection).to receive(:get).and_return(response)

      expect(client.search('Climate Change')).to eq(articles)
    end

    it 'raises an error for an invalid api key' do
      response = instance_double(Faraday::Response, status: 401)
      allow(connection).to receive(:get).and_return(response)

      expect { client.search('Climate Change') }
        .to raise_error(Currents::Error, 'Unauthorized: Invalid API key')
    end

    it 'raises an error when the rate limit is exceeded' do
      response = instance_double(Faraday::Response, status: 429)
      allow(connection).to receive(:get).and_return(response)

      expect { client.search('Climate Change') }
        .to raise_error(Currents::Error, 'Rate limit exceeded')
    end

    it 'raises an error for another api error' do
      response = instance_double(Faraday::Response, status: 500)
      allow(connection).to receive(:get).and_return(response)

      expect { client.search('Climate Change') }
        .to raise_error(Currents::Error, 'API error: 500')
    end
  end
end

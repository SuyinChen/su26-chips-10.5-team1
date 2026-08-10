# frozen_string_literal: true

require 'webmock/cucumber'

Before do
  ENV['CURRENTS_API_KEY'] = 'test-key'

  articles = [
    {
      title: 'Climate Article One',
      url: 'https://example.com/article1',
      description: 'First climate change article'
    },
    {
      title: 'Climate Article Two',
      url: 'https://example.com/article2',
      description: 'Second climate change article'
    },
    {
      title: 'Climate Article Three',
      url: 'https://example.com/article3',
      description: 'Third climate change article'
    },
    {
      title: 'Climate Article Four',
      url: 'https://example.com/article4',
      description: 'Fourth climate change article'
    },
    {
      title: 'Climate Article Five',
      url: 'https://example.com/article5',
      description: 'Fifth climate change article'
    }
  ]

  stub_request(:get, %r{api\.currentsapi\.services/v1/search})
    .to_return(
      status: 200,
      body: { news: articles }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )
end

After do
  ENV.delete('CURRENTS_API_KEY')
end

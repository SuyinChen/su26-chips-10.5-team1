# frozen_string_literal: true

require 'webmock/cucumber'
WebMock.disable_net_connect!(allow_localhost: true)

Before do
  ENV['GEOCODIO_API_KEY'] = 'test-key'

  stub_request(:post, /api\.geocod\.io/).to_return(
    status:  200,
    body:    Rails.root.join('spec/fixtures/geocodio_response.json').read,
    headers: { 'Content-Type' => 'application/json' }
  )
end

After do
  ENV.delete('GEOCODIO_API_KEY')
end

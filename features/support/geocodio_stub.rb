require 'webmock/cucumber'
WebMock.disable_net_connect!(allow_localhost: true)

Before do
  stub_request(:post, /api\.geocod\.io/).to_return(
  status:  200,
  body:    File.read(Rails.root.join('spec/fixtures/geocodio_response.json')),
  headers: { 'Content-Type' => 'application/json' }
  )
end
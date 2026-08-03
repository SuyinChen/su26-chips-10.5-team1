require 'webmock/cucumber'
WebMock.disable_net_connect!(allow_localhost: true)

Before do
  stub_request(:post, /api\.geocod\.io/).to_return(
  status:  200,
  body:    your_fixture_json,
  headers: { 'Content-Type' => 'application/json' }
  )
end
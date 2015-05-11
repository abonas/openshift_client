require 'test_helper'

# Client general tests
class TestClient < MiniTest::Test
  def test_api_valid
    client = OpenshiftClient::Client.new 'https://localhost:8080/osapi'
    assert_equal(true, client.respond_to?('api_valid?'))
  end
end

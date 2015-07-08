require 'test_helper'

# Client general tests
class TestClient < MiniTest::Test
  def test_api_valid
    client = OpenshiftClient::Client.new 'https://localhost:8080/oapi'
    assert_equal(true, client.respond_to?('api_valid?'))
  end

  def test_path_valid
    uri = URI::HTTPS.build(host: 'localhost', port: 8080)
    client2 = OpenshiftClient::Client.new uri
    assert_equal(true, client2.respond_to?('api_valid?'))
  end
end

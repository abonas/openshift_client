require 'test_helper'

def open_test_json_file(name)
  File.new(File.join(File.dirname(__FILE__), 'json', name))
end

# Project entity tests
class TestRoute < MiniTest::Test
  def test_get_routes
    stub_request(:get, /\/routes/)
      .to_return(body: open_test_json_file('route_b1.json'),
                 status: 200)

    client = OpenshiftClient::Client.new 'https://localhost:8080/osapi'
    route = client.get_route 'master'

    assert_instance_of(OpenshiftClient::Route, route)
    assert_equal('99135218-d927-11e4-9471-f8b156af4ae1', route.metadata.uid)
    assert_equal('route-edge', route.metadata.name)
    assert_equal('v1beta1', route.apiVersion)
  end
end

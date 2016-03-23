require 'test_helper'

# Project entity tests
class TestRoute < MiniTest::Test
  def test_get_routes
    stub_request(:get, %r{/routes})
      .to_return(body: open_test_file('route_b1.json'),
                 status: 200)

    client = OpenshiftClient::Client.new 'https://localhost:8080/oapi'
    route = client.get_route 'route-edge', 'default'

    assert_instance_of(OpenshiftClient::Route, route)
    assert_equal('6937497c-249d-11e5-9fe4-727174f8ab71', route.metadata.uid)
    assert_equal('route-edge', route.metadata.name)
    assert_equal('v1', route.apiVersion)
  end
end

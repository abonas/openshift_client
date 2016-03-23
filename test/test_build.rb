require 'test_helper'

# Build entity tests
class TestBuild < MiniTest::Test
  def test_get_builds
    stub_request(:get, %r{/builds})
      .to_return(body: open_test_file('builds_list.json'),
                 status: 200)

    client = OpenshiftClient::Client.new 'https://localhost:8080'
    builds = client.get_builds

    assert_instance_of(Kubeclient::Common::EntityList, builds)

    assert_equal(1, builds.size)
    assert_instance_of(OpenshiftClient::Build, builds[0])
    assert_requested(:get,
                     'https://localhost:8080/oapi/v1/builds',
                     times: 1)
  end

  def test_get_build
    stub_request(:get, %r{/builds})
      .to_return(body: open_test_file('build.json'),
                 status: 200)

    client = OpenshiftClient::Client.new 'https://localhost:8080'
    build = client.get_build 'ruby-sample-build-1', 'default'

    assert_instance_of(OpenshiftClient::Build, build)
    assert_equal('ruby-sample-build-1', build.metadata.name)
    assert_equal('v1', build.apiVersion)
    assert_equal('builder', build.spec.serviceAccount)

    assert_requested(:get,
                     'https://localhost:8080/oapi/v1/namespaces/default/builds/ruby-sample-build-1',
                     times: 1)
  end
end

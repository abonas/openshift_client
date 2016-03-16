require 'test_helper'

# Buildconfig entity tests
class TestBuildconfig < MiniTest::Test
  def test_get_buildconfigs
    stub_request(:get, %r{/buildconfigs})
      .to_return(body: open_test_file('buildconfigs_list.json'),
                 status: 200)

    client = OpenshiftClient::Client.new 'https://localhost:8080'
    buildconfigs = client.get_build_configs

    assert_instance_of(Kubeclient::Common::EntityList, buildconfigs)

    assert_equal(1, buildconfigs.size)
    assert_instance_of(OpenshiftClient::BuildConfig, buildconfigs[0])
    assert_requested(:get,
                     'https://localhost:8080/oapi/v1/buildconfigs',
                     times: 1)
  end

  def test_get_buildconfig
    stub_request(:get, %r{/buildconfigs})
      .to_return(body: open_test_file('buildconfig.json'),
                 status: 200)

    client = OpenshiftClient::Client.new 'https://localhost:8080'
    buildconfig = client.get_build_config 'ruby-sample-build', 'default'

    assert_instance_of(OpenshiftClient::BuildConfig, buildconfig)
    assert_equal('ruby-sample-build', buildconfig.metadata.name)
    assert_equal('v1', buildconfig.apiVersion)
    assert_equal('Git', buildconfig.spec.source.type)

    assert_requested(:get,
                     'https://localhost:8080/oapi/v1/namespaces/default/buildconfigs/ruby-sample-build',
                     times: 1)
  end
end

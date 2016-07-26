require 'test_helper'

# Template entity tests
class TestTemplate < MiniTest::Test
  def test_get_templates
    stub_request(:get, %r{/templates})
      .to_return(body: open_test_file('templates_list.json'),
                 status: 200)

    client = OpenshiftClient::Client.new 'https://localhost:8080'
    templates = client.get_templates

    assert_instance_of(Kubeclient::Common::EntityList, templates)
    assert_equal(1, templates.size)
    assert_instance_of(OpenshiftClient::Template, templates[0])
    assert_requested(:get,
                     'https://localhost:8080/oapi/v1/templates',
                     times: 1)
  end

  def test_get_template
    stub_request(:get, %r{/templates})
      .to_return(body: open_test_file('template.json'),
                 status: 200)

    client = OpenshiftClient::Client.new 'https://localhost:8080'
    template = client.get_template 'hawkular-cassandra-node-emptydir', 'openshift-infra'

    assert_instance_of(OpenshiftClient::Template, template)
    assert_equal('hawkular-cassandra-node-emptydir', template.metadata.name)
    assert_equal('v1', template.apiVersion)
    assert_equal('ReplicationController', template.objects[0]['kind'])

    assert_requested(:get,
                     'https://localhost:8080/oapi/v1/namespaces/openshift-infra/templates/hawkular-cassandra-node-emptydir',
                     times: 1)
  end
end

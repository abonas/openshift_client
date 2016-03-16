require 'test_helper'

# ClusterRoleBinding entity tests
class TestClusterRoleBinding < MiniTest::Test
  def test_get_cluster_role_binding
    stub_request(:get, %r{/clusterrolebindings/cluster-admins})
      .to_return(body: open_test_file('cluster_role_binding.json'),
                 status: 200)

    client = OpenshiftClient::Client.new 'https://localhost:8080/oapi'
    binding = client.get_cluster_role_binding('cluster-admins')

    assert_instance_of(OpenshiftClient::ClusterRoleBinding, binding)
    assert_equal('cluster-admins', binding.metadata.name)
    assert_equal([], binding.userNames)
    assert_equal(['system:cluster-admins'], binding.groupNames)
  end

  def test_get_cluster_role_bindings
    stub_request(:get, %r{/clusterrolebindings})
      .to_return(body: open_test_file('cluster_role_bindings_list.json'),
                 status: 200)

    client = OpenshiftClient::Client.new 'https://localhost:8080/oapi'
    cluster_role_bindings = client.get_cluster_role_bindings

    assert_instance_of(Kubeclient::Common::EntityList, cluster_role_bindings)

    assert_equal(16, cluster_role_bindings.size)
    assert_instance_of(OpenshiftClient::ClusterRoleBinding, cluster_role_bindings[1])
  end
end

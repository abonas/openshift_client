require 'test_helper'

def open_test_json_file(name)
  File.new(File.join(File.dirname(__FILE__), 'json', name))
end

# SecurityContextConstraint entity tests
class TestSecurityContextConstraint < MiniTest::Test
  def test_get_security_context_constraint
    stub_request(:get, %r{/securitycontextconstraints/privileged})
      .to_return(body: open_test_json_file('security_context_constraint.json'),
                 status: 200)

    client = OpenshiftClient::Client.new 'https://localhost:8080/oapi'
    constraint = client.get_security_context_constraint('privileged')

    assert_instance_of(OpenshiftClient::SecurityContextConstraint, constraint)
    assert_equal('privileged', constraint.metadata.name)
    assert_equal(true, constraint.allowPrivilegedContainer)
    assert_equal(true, constraint.allowHostNetwork)
  end

  def test_get_security_context_constraints
    stub_request(:get, %r{/securitycontextconstraints})
      .to_return(body: open_test_json_file('security_context_constraints_list.json'),
                 status: 200)

    client = OpenshiftClient::Client.new 'https://localhost:8080/oapi'
    security_context_constraints = client.get_security_context_constraints

    assert_instance_of(Kubeclient::Common::EntityList, security_context_constraints)

    assert_equal(2, security_context_constraints.size)
    assert_instance_of(OpenshiftClient::SecurityContextConstraint, security_context_constraints[1])
  end
end

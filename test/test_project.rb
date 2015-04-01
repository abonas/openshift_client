require 'test_helper'

def open_test_json_file(name)
  File.new(File.join(File.dirname(__FILE__), 'json', name))
end

# Project entity tests
class TestProject < MiniTest::Test
  def test_get_project
    stub_request(:get, /\/projects/)
      .to_return(body: open_test_json_file('project_b1.json'),
                 status: 200)

    client = OpenshiftClient::Client.new 'https://localhost:8080/osapi'
    project = client.get_project 'master'

    assert_instance_of(OpenshiftClient::Project, project)
    assert_equal('80359e00-d874-11e4-b110-f8b156af4ae1', project.metadata.uid)
    assert_equal('master', project.metadata.name)
    assert_equal('36', project.metadata.resourceVersion)
    assert_equal('v1beta1', project.apiVersion)
  end

  def test_get_projects
    stub_request(:get, /\/projects/)
    .to_return(body: open_test_json_file('project_list_b1.json'),
               status: 200)

    client = OpenshiftClient::Client.new 'https://localhost:8080/osapi'
    projects = client.get_projects

    assert_instance_of(Kubeclient::Common::EntityList, projects)

    assert_equal(2, projects.size)
    assert_instance_of(OpenshiftClient::Project, projects[1])
  end

  def test_p
    # temp test for real env
    # WebMock.allow_net_connect!
    # client = OpenshiftClient::Client.new 'https://<IP>:8443/osapi'
    # client.ssl_options(verify_ssl: OpenSSL::SSL::VERIFY_NONE)
    # projects = client.get_projects
  end
end

require 'test_helper'

def open_test_json_file(name)
  File.new(File.join(File.dirname(__FILE__), 'json', name))
end

# Project entity tests
class TestProject < MiniTest::Test
  def test_get_project
    stub_request(:get, %r{/projects})
      .to_return(body: open_test_json_file('project_b1.json'),
                 status: 200)

    client = OpenshiftClient::Client.new 'https://localhost:8080/oapi'
    project = client.get_project 'test'

    assert_instance_of(OpenshiftClient::Project, project)
    assert_equal('2626e632-2491-11e5-9fe4-727174f8ab71', project.metadata.uid)
    assert_equal('test', project.metadata.name)
    assert_equal('241', project.metadata.resourceVersion)
    assert_equal('v1', project.apiVersion)
  end

  def test_get_projects
    stub_request(:get, %r{/projects})
      .to_return(body: open_test_json_file('project_list_b1.json'),
                 status: 200)

    client = OpenshiftClient::Client.new 'https://localhost:8080/oapi'
    projects = client.get_projects

    assert_instance_of(Kubeclient::Common::EntityList, projects)

    assert_equal(5, projects.size)
    assert_instance_of(OpenshiftClient::Project, projects[1])
  end
end

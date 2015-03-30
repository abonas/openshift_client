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
    project = client.get_project 'staging'

    assert_instance_of(OpenshiftClient::Project, project)
    assert_equal('e388bc10-c021-11e4-a514-3c970e4a436a', project.metadata.uid)
    assert_equal('staging', project.metadata.name)
    assert_equal('1168', project.metadata.resourceVersion)
    assert_equal('v1beta1', project.apiVersion)
  end
end

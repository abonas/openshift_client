require 'test_helper'

def open_test_json_file(name)
  File.new(File.join(File.dirname(__FILE__), 'json', name))
end

# ImageStream entity tests
class TestImageStream < MiniTest::Test
  def test_get_image_streams
    stub_request(:get, %r{/imagestreams})
      .to_return(body: open_test_json_file('image_streams_list.json'),
                 status: 200)

    client = OpenshiftClient::Client.new 'https://localhost:8080'
    image_streams = client.get_image_streams

    assert_instance_of(Kubeclient::Common::EntityList, image_streams)

    assert_equal(1, image_streams.size)
    assert_instance_of(OpenshiftClient::ImageStream, image_streams[0])
    assert_requested(:get,
                     'https://localhost:8080/oapi/v1/imagestreams',
                     times: 1)
  end

  def test_get_image_stream
    stub_request(:get, %r{/imagestreams})
      .to_return(body: open_test_json_file('image_stream.json'),
                 status: 200)

    client = OpenshiftClient::Client.new 'https://localhost:8080'
    image_stream = client.get_image_stream 'eng-boss-image-inspector', 'default'

    assert_instance_of(OpenshiftClient::ImageStream, image_stream)
    assert_equal('eng-boss-image-inspector', image_stream.metadata.name)
    assert_equal('v1', image_stream.apiVersion)
    assert_equal('172.30.107.74:5000/default/eng-boss-image-inspector',
                 image_stream.status.dockerImageRepository)

    assert_requested(:get,
                     'https://localhost:8080/oapi/v1/namespaces/default/imagestreams/eng-boss-image-inspector',
                     times: 1)
  end
end

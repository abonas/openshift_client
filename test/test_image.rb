require 'test_helper'

def open_test_json_file(name)
  File.new(File.join(File.dirname(__FILE__), 'json', name))
end

# Image entity tests
class TestImage < MiniTest::Test
  def test_get_images
    stub_request(:get, %r{/images})
      .to_return(body: open_test_json_file('images_list.json'),
                 status: 200)

    client = OpenshiftClient::Client.new 'https://localhost:8080'
    images = client.get_images

    assert_instance_of(Kubeclient::Common::EntityList, images)

    assert_equal(1, images.size)
    assert_instance_of(OpenshiftClient::Image, images[0])
    assert_requested(:get,
                     'https://localhost:8080/oapi/v1/images',
                     times: 1)
  end

  def test_get_image
    stub_request(:get, %r{/images})
      .to_return(body: open_test_json_file('image.json'),
                 status: 200)

    client = OpenshiftClient::Client.new 'https://localhost:8080'
    image = client.get_image 'sha256:9b214cc086795a08f41b55553e21a311bda2408cee537a40c4d785b44bd24',
                             'default'

    assert_instance_of(OpenshiftClient::Image, image)
    assert_equal(
      'sha256:9b214cc086795a08f41b55553e21a311bda2408cee537a40c4d785b44bd24',
      image.metadata.name)
    assert_equal('v1', image.apiVersion)
    assert_equal('DockerImage', image.dockerImageMetadata.kind)

    assert_requested(:get,
                     'https://localhost:8080/oapi/v1/namespaces/default/images/sha256:9b214cc0867'\
                     '95a08f41b55553e21a311bda2408cee537a40c4d785b44bd24',
                     times: 1)
  end
end

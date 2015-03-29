require 'minitest/autorun'
require 'webmock/minitest'
require 'json'
require 'openshift_client'

def open_test_json_file(name)
  File.new(File.join(File.dirname(__FILE__), 'json', name))
end

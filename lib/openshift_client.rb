require 'openshift_client/version'
require 'active_support/inflector'
require 'kubeclient/entity_list'
require 'kubeclient/kube_exception'
require 'kubeclient/watch_notice'
require 'kubeclient/watch_stream'
require 'kubeclient/common'

module OpenshiftClient
  # Openshift Client
  class Client < Kubeclient::Common::Client
    attr_reader :api_endpoint

    # Dynamically creating classes definitions (class Project, class Pod, etc.),
    # The classes are extending RecursiveOpenStruct.
    # This cancels the need to define the classes
    # manually on every new entity addition,
    # and especially since currently the class body is empty
    ENTITY_TYPES = %w(Project Route).map do |et|
      [OpenshiftClient.const_set(et, Class.new(RecursiveOpenStruct)), et]
    end

    def initialize(uri, version = 'v1', path = '/oapi')
      handle_uri(uri, path)
      @api_version = version
      @headers = {}
      ssl_options
    end

    def all_entities
      retrieve_all_entities(ENTITY_TYPES)
    end

    define_entity_methods(ENTITY_TYPES)
  end
end

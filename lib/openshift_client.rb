require 'openshift_client/version'
require 'json'
require 'rest-client'
require 'active_support/inflector'
require 'kubeclient/entity_list'
require 'kubeclient/kube_exception'
require 'kubeclient/watch_notice'
require 'kubeclient/watch_stream'
require 'kubeclient/common'

module OpenshiftClient
  # Kubernetes Client
  class Client < Common::Client
    attr_reader :api_endpoint

    # Dynamically creating classes definitions (class Pod, class Service, etc.),
    # The classes are extending RecursiveOpenStruct.
    # This cancels the need to define the classes
    # manually on every new entity addition,
    # and especially since currently the class body is empty
    ENTITY_TYPES = %w(Project).map do |et|
      [OpenshiftClient.const_set(et, Class.new(RecursiveOpenStruct)), et]
    end

    def initialize(uri, version = 'v1beta1')
      handle_uri(uri, '/osapi')
      @api_version = version
      ssl_options
    end

    def all_entities
      retrieve_all_entities(ENTITY_TYPES)
    end

    define_entity_methods(ENTITY_TYPES)
  end
end

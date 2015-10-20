require 'openshift_client/version'
require 'active_support/inflector'
require 'kubeclient/entity_list'
require 'kubeclient/kube_exception'
require 'kubeclient/watch_notice'
require 'kubeclient/watch_stream'
require 'kubeclient/common'

module OpenshiftClient
  # Openshift Client
  class Client
    include Kubeclient::ClientMixin

    # Dynamically creating classes definitions (class Project, class Pod, etc.),
    # The classes are extending RecursiveOpenStruct.
    # This cancels the need to define the classes
    # manually on every new entity addition,
    # and especially since currently the class body is empty
    ENTITY_TYPES = %w(Project Route SecurityContextConstraint ClusterRoleBinding).map do |et|
      [OpenshiftClient.const_set(et, Class.new(RecursiveOpenStruct)), et]
    end

    Kubeclient::ClientMixin.define_entity_methods(ENTITY_TYPES)

    def initialize(uri,
                   version = 'v1',
                   path = '/oapi',
                   ssl_options: {
                     client_cert: nil,
                     client_key: nil,
                     ca_file: nil,
                     verify_ssl: OpenSSL::SSL::VERIFY_PEER
                   },
                   auth_options: {
                     username:          nil,
                     password:          nil,
                     bearer_token:      nil,
                     bearer_token_file: nil
                   }
                  )
      initialize_client(uri, path, version, ssl_options: ssl_options, auth_options: auth_options)
    end

    def all_entities
      retrieve_all_entities(ENTITY_TYPES)
    end
  end
end

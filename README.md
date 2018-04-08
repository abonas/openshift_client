# OpenshiftClient

## Deprecated — now covered by [Kubeclient](https://github.com/abonas/kubeclient)

This gem is no longer being developed.  It is not compatible, but also not necessary, with kubeclient 2.0.0 or later.

### Transition tips (valid as of kubeclient 2.x – 4.2)

Kubeclient gem since 2.0.0 is [capable of API discovery](https://github.com/abonas/kubeclient/pull/185) on any api extensions, including openshift.  Simply construct a additional client with `/oapi` url:
```
kclient = Kubeclient::Client.new('https://localhost:8443/api')
kclient.get_pods

oclient = Kubeclient::Client.new('https://localhost:8443/oapi')
oclient.get_routes
```

Since openshift 3.6, instead of `oapi` you MAY also access all openshift entities under separate api groups at standard apis/ path, for example:
```
template_client = Kubeclient::Client.new('https://localhost:8443/apis/template.openshift.io', 'v1')
template_client.get_templates
```
(but this currently requires many more separate client objects)

Don't use resource-specific classes such as `Kubeclient::Service` or `OpenshiftClient::Route`, just use `Kubeclient::Resource` for everything.

See also [Kubeclient's changelog](https://github.com/abonas/kubeclient/blob/master/CHANGELOG.md).

----

[![Gem Version](https://badge.fury.io/rb/openshift_client.svg)](http://badge.fury.io/rb/openshift_client)
[![Build Status](https://travis-ci.org/abonas/openshift_client.svg?branch=master)](https://travis-ci.org/abonas/openshift_client)
[![Code Climate](http://img.shields.io/codeclimate/github/abonas/openshift_client.svg)](https://codeclimate.com/github/abonas/openshift_client)
[![Dependency Status](https://gemnasium.com/abonas/openshift_client.svg)](https://gemnasium.com/abonas/openshift_client)

A Ruby client for Openshift REST api.
The client currently supports Openshift REST api version v1beta1.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'openshift_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install openshift_client

## Usage

TODO: Write usage instructions here
Initialize the client:
client = OpenshiftClient::Client.new 'https://hostName:8443'

## Contributing

1. Fork it ( https://github.com/[my-github-username]/openshift_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Test your changes with `rake test rubocop`, add new tests if needed.
4. If you added a new functionality, add it to README
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create a new Pull Request

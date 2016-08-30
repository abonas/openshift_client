# OpenshiftClient


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

#### Process a template
Returns a processed template containing a list of objects to create.
Input parameter - template (hash)
Besides its metadata, the template should include a list of objects to be processed and a list of parameters
to be substituted. Note that for a required parameter that does not provide a generated value, you must supply a value.

```ruby
client.process_template template
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/openshift_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Test your changes with `rake test rubocop`, add new tests if needed.
4. If you added a new functionality, add it to README
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create a new Pull Request

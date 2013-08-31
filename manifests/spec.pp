# Class: graylog2::spec
#
# This class is used only for rpsec-puppet tests
# Can be taken as an example on how to do custom classes but should not
# be modified.
#
# == Usage
#
# This class is not intended to be used directly.
# Use it as reference
#
class graylog2::spec inherits graylog2::config {

  # This just a test to override the arguments of an existing resource
  # Note that you can achieve this same result with just:
  # class { "graylog2": template => "graylog2/spec.erb" }

  File['graylog2.conf'] {
    content => template('graylog2/spec.erb'),
  }

}

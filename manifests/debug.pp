# = Class: graylog2::debug
#
# Debug class for graylog2
#
class graylog2::debug {

  file { 'debug_graylog2':
    ensure  => $graylog2::manage_file,
    path    => "${settings::vardir}/debug-graylog2",
    mode    => '0640',
    owner   => 'root',
    group   => 'root',
    content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
    noop    => $graylog2::noops,
  }

}

# Class: graylog2::webinterface::webrick
#
# This class configures webrick for graylog2 webinterface
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by graylog2
#
class graylog2::webinterface::webrick {

  service { 'graylog2-webinterface':
    ensure     => $graylog2::manage_service_ensure,
    name       => 'graylog2-webinterface',
    enable     => $graylog2::manage_service_enable,
    hasstatus  => true,
    noop       => $graylog2::noops,
  }

  file { '/etc/init.d/graylog2-webinterface':
    ensure  => $graylog2::manage_file,
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    content => template($graylog2::webinterface_init_script_template),
    replace => $graylog2::manage_file_replace,
    audit   => $graylog2::manage_audit,
    noop    => $graylog2::noops,
    before  => Service['graylog2-webinterface'],
  }
}


# Class: graylog2::service
#
# This class manages graylog2 service
#
# == Variables
#
# Refer to graylog2 class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by graylog2
#
class graylog2::service {

  case $graylog2::install {

    package: {
      service { 'graylog2':
        ensure     => $graylog2::manage_service_ensure,
        name       => $graylog2::service,
        enable     => $graylog2::manage_service_enable,
        hasstatus  => $graylog2::service_status,
        pattern    => $graylog2::process,
        noop       => $graylog2::noops,
      }
    }

    source,puppi: {
      service { 'graylog2-server':
        ensure     => $graylog2::manage_service_ensure,
        name       => $graylog2::service,
        enable     => $graylog2::manage_service_enable,
        hasstatus  => $graylog2::service_status,
        pattern    => $graylog2::process,
        noop       => $graylog2::noops,
        provider   => 'init',
      }
      file { '/etc/init.d/graylog2-server':
        ensure  => $graylog2::manage_file,
        mode    => '0755',
        owner   => 'root',
        group   => 'root',
        content => template($graylog2::init_script_template),
        replace => $graylog2::manage_file_replace,
        audit   => $graylog2::manage_audit,
        noop    => $graylog2::noops,
        before  => Service['graylog2-server'],
      }
    }

    default: { }

  }

}

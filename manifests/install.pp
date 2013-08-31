# Class: graylog2::install
#
# This class installs graylog2
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
class graylog2::install {

  case $graylog2::install {

    package: {
      package { 'graylog2':
        ensure => $graylog2::manage_package,
        name   => $graylog2::package,
        noop   => $graylog2::noops,
      }
    }

    source: {
      if $graylog2::bool_create_user == true {
        require graylog2::user
      }
      puppi::netinstall { 'netinstall_graylog2':
        url                 => $graylog2::real_install_source,
        destination_dir     => $graylog2::install_destination,
        extracted_dir       => $graylog2::created_dirname,
        owner               => $graylog2::process_user,
        group               => $graylog2::process_group,
        noop                => $graylog2::noops,
      }

      file { 'graylog2_link':
        ensure => $graylog2::home,
        path   => "${graylog2::install_destination}/graylog2",
        noop   => $graylog2::noops,
      }
    }

    puppi: {
      if $graylog2::bool_create_user == true {
        require graylog2::user
      }

      puppi::project::archive { 'graylog2':
        source      => $graylog2::real_install_source,
        deploy_root => $graylog2::install_destination,
        user        => $graylog2::process_user,
        auto_deploy => true,
        enable      => true,
        noop        => $graylog2::noops,
      }

      file { 'graylog2_link':
        ensure => $graylog2::home,
        path   => "${graylog2::install_destination}/graylog2",
        noop   => $graylog2::noops,
      }

    }

    default: { }

  }

}

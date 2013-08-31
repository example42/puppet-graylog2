# Class: graylog2::webinterface
#
# This class installs graylog2 webinterface
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
class graylog2::webinterface {

  case $graylog2::install {

    package: {
      package { 'graylog2-webinterface':
        ensure => $graylog2::manage_package,
        name   => $graylog2::webinterface_package,
        noop   => $graylog2::noops,
        before => File['graylog2-mongoid.yml'],
      }
    }

    source: {
      puppi::netinstall { 'netinstall_graylog2-webinterface':
        url                 => $graylog2::real_webinterface_install_source,
        destination_dir     => $graylog2::webinterface_install_destination,
        extracted_dir       => $graylog2::webinterface_created_dirname,
        owner               => $graylog2::process_user,
        group               => $graylog2::process_group,
        noop                => $graylog2::noops,
        before              => File['graylog2-mongoid.yml'],
      }

      file { 'graylog2-webinterface_link':
        ensure => $graylog2::webinterface_home,
        path   => "${graylog2::install_destination}/graylog2-web-interface",
        noop   => $graylog2::noops,
      }
    }

    puppi: {
      if $graylog2::bool_create_user == true {
        require graylog2::user
      }

      puppi::project::archive { 'graylog2-webinterface':
        source      => $graylog2::real_webinterface_install_source,
        deploy_root => $graylog2::webinterface_install_destination,
        user        => $graylog2::process_user,
        auto_deploy => true,
        enable      => true,
        noop        => $graylog2::noops,
        before      => File['graylog2-mongoid.yml'],
      }

      file { 'graylog2-webinterface_link':
        ensure => $graylog2::webinterface_home,
        path   => "${graylog2::install_destination}/graylog2-web-interface",
        noop   => $graylog2::noops,
      }
    }

    default: { }

  }

  file { 'graylog2-mongoid.yml':
    ensure  => $graylog2::manage_file,
    path    => "${graylog2::webinterface_home}/config/mongoid.yml" ,
    mode    => $graylog2::config_file_mode,
    owner   => $graylog2::config_file_owner,
    group   => $graylog2::config_file_group,
    content => template('graylog2/mongoid.yml.erb'),
    replace => $graylog2::manage_file_replace,
    audit   => $graylog2::manage_audit,
    noop    => $graylog2::noops,
  }
}

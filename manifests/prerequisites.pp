# Class: graylog2::prerequisites
#
# This class installs graylog2 prerequisites
#
# == Variables
#
# Refer to graylog2 class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by graylog2 if the parameter
# install_prerequisites is set to true
# Note: This class may contain resources available on the
# Example42 modules set
#
class graylog2::prerequisites {

  include java
  include mongodb
  include elasticsearch

/*
  # Service wrapper setup 
  if $graylog2::source != 'package' {
    git::reposync { 'graylog2-servicewrapper':
      source_url      => 'https://github.com/rodrigopalhares/graylog2-servicewrapper.git',
      destination_dir => "${graylog2::install_destination}/graylog2-servicewrapper",
      post_command    => "cp -a ${graylog2::install_destination}/graylog2-servicewrapper/service ${graylog2::home}/bin ; chown -R ${graylog2::process_user}:${graylog2::process_user} ${graylog2::home}/bin/service",
      require         => Class['graylog2::install'],
      before          => [ Class['graylog2::service'] , Class['graylog2::config'] ],
    }
    file { "${graylog2::home}/bin/service/graylog2":
      ensure  => present,
      mode    => 0755,
      owner   => $graylog2::process_user,
      group   => $graylog2::process_user,
      content => template($graylog2::init_script_template),
      before  => Class['graylog2::service'],
      require => Git::Reposync['graylog2-servicewrapper'],
    }
    file { "/etc/init.d/graylog2":
      ensure  => "${graylog2::home}/bin/service/graylog2",
    }
    file { "${graylog2::home}/bin/service/graylog2.conf":
      ensure  => present,
      mode    => 0644,
      owner   => $graylog2::process_user,
      group   => $graylog2::process_user,
      content => template($graylog2::init_config_template),
      before  => Class['graylog2::service'],
      require => Git::Reposync['graylog2-servicewrapper'],
    }
    file { "${graylog2::home}/logs":
      ensure  => directory,
      mode    => 0755,
      owner   => $graylog2::process_user,
      group   => $graylog2::process_user,
      before  => Class['graylog2::service'],
      require => Git::Reposync['graylog2-servicewrapper'],
    }
  }
*/
}

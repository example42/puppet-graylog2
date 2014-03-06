# Class: graylog2::dependencies
#
# This class installs graylog2 dependencies
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by default in graylog2 by the parameter
# dependencies_class. You may provide an alternative class name to
# provide the same resources (eventually not using Example42 modules)
#
class graylog2::dependencies {

  # Dependencies for graylog2-server
  if $graylog2::install == 'source'
  or $graylog2::install == 'puppi' {
    include java
    include elasticsearch
    include mongodb
    if $graylog2::mongo_db_host == '127.0.0.1'
    or $graylog2::mongo_db_host == 'localhost' {
      mongodb::user { $graylog2::mongo_user:
        db_name  => $graylog2::mongo_db_name,
        password => $graylog2::mongo_password,
      }
    } else {
      # Totally untested - Requires storeconfigs
      # Collect on mongo_db_host with something like:
      # Mongodb::User <<| tag == "mongo_user_${ipaddress}"|>>
      # Mongodb::User <<| tag == "mongo_user_${fqdn}"|>>
      @@mongodb::user { $graylog2::mongo_user:
        db_name  => $graylog2::mongo_db_name,
        password => $graylog2::mongo_password,
        tag      => "mongo_user_${graylog2::mongo_db_host}",
      }
    }
  }

  # Dependencies for graylog2-web-interface
  if $graylog2::webinterface_install == 'source'
  or $graylog2::webinterface_install == 'puppi' {
    bundler::install { 'graylog2-webinterface':
      install_path => $graylog2::webinterface_home,
      unless       => 'which rails',
      refreshonly  => false,
      require      => [ Class['ruby'] , Class['graylog2::webinterface'] ],
    }

    case $graylog2::webinterface_webserver {
      'apache': { include graylog2::webinterface::apache }
      'webrick': { include graylog2::webinterface::webrick }
      default : { }
    }

    # Ruby 1.9.3 required. Installed from source.
    $ruby_package = $::operatingsystem ? {
      /(?i:Debian|Ubuntu|Mint)/       => 'ruby1.9.3',
      default                         => 'ruby',
    }

    class { 'ruby':
      version             => '1.9.3-p392',
      compile_from_source => true,
    }

  }

}

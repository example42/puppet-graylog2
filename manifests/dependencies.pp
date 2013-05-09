# Class: graylog2::dependencies
#
# This class installs graylog2 prerequisites
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by graylog2 if the parameter
# install_prerequisites is set to true
# Note: This class may contain resources available on the
# Example42 modules set
#
class graylog2::dependencies {

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
    # Collect on mongo_db_host with something like:
    # Mongodb::User <<| tag == "mongo_user_${ipaddress}"|>>
    # Mongodb::User <<| tag == "mongo_user_${fqdn}"|>>
    @@mongodb::user { $graylog2::mongo_user:
      db_name  => $graylog2::mongo_db_name,
      password => $graylog2::mongo_password,
      tag      => "mongo_user_$graylog2::mongo_db_host",
    }
  }

}

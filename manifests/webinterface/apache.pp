# Class: graylog2::webinterface::apache
#
# This class configures apache for graylog2 webinterface
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by graylog2
#
class graylog2::webinterface::apache {

  include apache::passenger
  apache::vhost { $graylog2::webinterface_virtualhost :
    docroot             => "${graylog2::webinterface_home}/public",
    passenger           => true,
    passenger_rails_env => 'production',
  }

}


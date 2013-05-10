# Class: graylog2::user
#
# This class creates graylog2 user
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by graylog2
#
class graylog2::user {
  @user { $graylog2::process_user :
    ensure     => $graylog2::manage_file,
    comment    => "${graylog2::process_user} user",
    password   => '!',
    managehome => false,
    home       => $graylog2::home,
    shell      => '/bin/bash',
  }
  @group { $graylog2::process_group :
    ensure     => $graylog2::manage_file,
  }

  User <| title == $graylog2::process_user |>
  Group <| title == $graylog2::process_group |>

}

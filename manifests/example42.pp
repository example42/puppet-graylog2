# = Class: graylog2::example42
#
# This iclass contains Example42 extensions for
# the graylog2 module
#
class graylog2::example42 {

  ### Provide puppi data, if enabled ( puppi => true )
  if $graylog2::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'graylog2':
      ensure    => $graylog2::manage_file,
      variables => $classvars,
      helper    => $graylog2::puppi_helper,
      noop      => $graylog2::noops,
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $graylog2::bool_monitor == true {
    if $graylog2::protocol == 'tcp' {
      monitor::port { "graylog2_${graylog2::protocol}_${graylog2::port}":
        protocol => $graylog2::protocol,
        port     => $graylog2::port,
        target   => $graylog2::monitor_target,
        tool     => $graylog2::monitor_tool,
        enable   => $graylog2::manage_monitor,
        noop     => $graylog2::noops,
      }
    }
    if $graylog2::service != '' {
      monitor::process { 'graylog2_process':
        process  => $graylog2::process,
        service  => $graylog2::service,
        pidfile  => $graylog2::pid_file,
        user     => $graylog2::process_user,
        argument => $graylog2::process_args,
        tool     => $graylog2::monitor_tool,
        enable   => $graylog2::manage_monitor,
        noop     => $graylog2::noops,
      }
    }
  }


  ### Firewall management, if enabled ( firewall => true )
  if $graylog2::bool_firewall == true and $graylog2::port != '' {
    firewall { "graylog2_${graylog2::protocol}_${graylog2::port}":
      source      => $graylog2::firewall_src,
      destination => $graylog2::firewall_dst,
      protocol    => $graylog2::protocol,
      port        => $graylog2::port,
      action      => 'allow',
      direction   => 'input',
      tool        => $graylog2::firewall_tool,
      enable      => $graylog2::manage_firewall,
      noop        => $graylog2::noops,
    }
  }

}

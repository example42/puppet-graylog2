# Class: graylog2::params
#
# This class defines default parameters used by the main module class graylog2
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to graylog2 class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class graylog2::params {

  ### Application related parameters

  $install_prerequisites = true
  $create_user           = true
  $install               = 'source'

  $elasticsearch_template = 'graylog2/elasticsearch.yml.erb'
  $elasticsearch_path = '/etc/graylog2-elasticsearch.yml'
  $version = '0.11.0'
  $base_url_default = 'http:://download.graylog2.org/graylog2-server/'

  $install_source        = ''
  $install_destination   = '/opt'
  $init_config_template  = 'graylog2/graylog2-wrapper.conf.erb'
  $init_script_template  = 'graylog2/graylog2.init.erb'

  $package = $::operatingsystem ? {
    default => 'graylog2',
  }

  $service = $::operatingsystem ? {
    default => 'graylog2-server',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'java',
  }

  $process_args = $::operatingsystem ? {
    default => 'graylog2',
  }

  $process_user = $::operatingsystem ? {
    default => 'graylog2',
  }

  $process_group = $::operatingsystem ? {
    default => 'graylog2',
  }

  $config_dir = $::operatingsystem ? {
    default => '',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/graylog2.conf',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/graylog2',
    default                   => '/etc/sysconfig/graylog2',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/graylog2.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/etc/graylog2',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/graylog2',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/graylog2/graylog2.log',
  }

  $port = '514'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = 'graylog2/graylog2.conf.erb'
  $options = ''
  $service_autorestart = true
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false
  $noops = false

}

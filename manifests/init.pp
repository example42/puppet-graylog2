# = Class: graylog2
#
# This is the main graylog2 class
#
#
# == Parameters
#
# [*dependencies_class*]
#   The name of the class that installs dependencies and prerequisite
#   resources needed by this module.
#   Default is $graylog2::dependencies which uses Example42 modules.
#   Set to '' false to not install any dependency (you must provide what's
#   defined in graylog2/manifests/dependencies.pp in some way).
#   Set directy the name of a custom class to manage there the dependencies
#
# [*create_user*]
#   Set to true if you want the module to create the process user of graylog2
#   (as defined in $logstagh::process_user). Default: true
#   Note: User is not created when $graylog2::install is package
#
# [*install*]
#   Kind of installation to attempt:
#     - package : Installs graylog2 using the OS common packages
#     - source  : Installs graylog2 downloading and extracting a specific
#                 tarball or zip file
#     - puppi   : Installs graylog2 tarball or file via Puppi, creating the
#                 "puppi deploy graylog2" command
#   Can be defined also by the variable $graylog2_install
#
# [*install_source*]
#   The URL from where to retrieve the source archive.
#   Used if install => "source" or "puppi"
#   Default is from upstream developer site. Update the version when needed.
#   Can be defined also by the variable $graylog2_install_source
#
# [*install_destination*]
#   The base path where to extract the source archive.
#   Used if install => "source" or "puppi"
#   Can be defined also by the variable $graylog2_install_destination
#
# [*elasticsearch_template*]
#   Sets the path to the template to use as content for the elasticsearch.yml file
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, graylog2 class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $graylog2_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, graylog2 main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $graylog2_source
#
# [*source_dir*]
#   If defined, the whole graylog2 configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $graylog2_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the (top scope) variable $graylog2_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, graylog2 main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $graylog2_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $graylog2_options
#
# [*service_autorestart*]
#   Automatically restarts the graylog2 service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $graylog2_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $graylog2_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $graylog2_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $graylog2_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for graylog2 checks
#   Can be defined also by the (top scope) variables $graylog2_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the (top scope) variables $graylog2_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $graylog2_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $graylog2_puppi_helper
#   and $puppi_helper
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $graylog2_firewall
#   and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module)
#   you want to use to open firewall for graylog2 port(s)
#   Can be defined also by the (top scope) variables $graylog2_firewall_tool
#   and $firewall_tool
#
# [*firewall_src*]
#   Define which source ip/net allow for firewalling graylog2. Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $graylog2_firewall_src
#   and $firewall_src
#
# [*firewall_dst*]
#   Define which destination ip to use for firewalling. Default: $ipaddress
#   Can be defined also by the (top scope) variables $graylog2_firewall_dst
#   and $firewall_dst
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $graylog2_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $graylog2_audit_only
#   and $audit_only
#
# [*noops*]
#   Set noop metaparameter to true for all the resources managed by the module.
#   Basically you can run a dryrun for this specific module if you set
#   this to true. Default: undef
#
# Default class params - As defined in graylog2::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of graylog2 package
#
# [*service*]
#   The name of graylog2 service
#
# [*service_status*]
#   If the graylog2 service init script supports status argument
#
# [*process*]
#   The name of graylog2 process
#
# [*process_args*]
#   The name of graylog2 arguments. Used by puppi and monitor.
#   Used only in case the graylog2 process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user graylog2 runs with.
#
# [*process_group*]
#   The name of the group graylog2 runs with.
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*config_file_init*]
#   Path of configuration file sourced by init script
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $graylog2_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $graylog2_protocol
#
#
# See README for usage patterns.
#
class graylog2 (
  $webinterface_install             = params_lookup( 'webinterface_install'),
  $webinterface_install_source      = params_lookup( 'webinterface_install_source'),
  $webinterface_install_destination = params_lookup( 'webinterface_install_destination'),
  $webinterface_virtualhost         = params_lookup( 'webinterface_virtualhost'),
  $webinterface_webserver           = params_lookup( 'webinterface_webserver'),
  $webinterface_package             = params_lookup( 'webinterface_package'),
  $webinterface_init_script_template = params_lookup( 'webinterface_init_script_template'),
  $webinterface_rails_environment    = params_lookup( 'webinterface_rails_environment'),
  $dependencies_class    = params_lookup( 'dependencies_class' ),
  $create_user           = params_lookup( 'create_user' ),
  $install               = params_lookup( 'install' ),
  $install_source        = params_lookup( 'install_source' ),
  $install_destination   = params_lookup( 'install_destination' ),
  $init_config_template  = params_lookup( 'init_config_template' ),
  $init_script_template  = params_lookup( 'init_script_template' ),
  $elasticsearch_template  = params_lookup( 'elasticsearch_template' ),
  $elasticsearch_path      = params_lookup( 'elasticsearch_path' ),
  $mongo_db_host         = params_lookup( 'mongo_db_host' ),
  $mongo_db_port         = params_lookup( 'mongo_db_port' ),
  $mongo_db_name         = params_lookup( 'mongo_db_name' ),
  $mongo_user            = params_lookup( 'mongo_user' ),
  $mongo_password        = params_lookup( 'mongo_password' ),
  $java_opts             = params_lookup( 'java_opts' ),
  $my_class              = params_lookup( 'my_class' ),
  $source                = params_lookup( 'source' ),
  $source_dir            = params_lookup( 'source_dir' ),
  $source_dir_purge      = params_lookup( 'source_dir_purge' ),
  $template              = params_lookup( 'template' ),
  $options               = params_lookup( 'options' ),
  $service_autorestart   = params_lookup( 'service_autorestart' , 'global' ),
  $version               = params_lookup( 'version' ),
  $absent                = params_lookup( 'absent' ),
  $disable               = params_lookup( 'disable' ),
  $disableboot           = params_lookup( 'disableboot' ),
  $monitor               = params_lookup( 'monitor' , 'global' ),
  $monitor_tool          = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target        = params_lookup( 'monitor_target' , 'global' ),
  $puppi                 = params_lookup( 'puppi' , 'global' ),
  $puppi_helper          = params_lookup( 'puppi_helper' , 'global' ),
  $firewall              = params_lookup( 'firewall' , 'global' ),
  $firewall_tool         = params_lookup( 'firewall_tool' , 'global' ),
  $firewall_src          = params_lookup( 'firewall_src' , 'global' ),
  $firewall_dst          = params_lookup( 'firewall_dst' , 'global' ),
  $debug                 = params_lookup( 'debug' , 'global' ),
  $audit_only            = params_lookup( 'audit_only' , 'global' ),
  $noops                 = params_lookup( 'noops' ),
  $package               = params_lookup( 'package' ),
  $service               = params_lookup( 'service' ),
  $service_status        = params_lookup( 'service_status' ),
  $process               = params_lookup( 'process' ),
  $process_args          = params_lookup( 'process_args' ),
  $process_user          = params_lookup( 'process_user' ),
  $process_group         = params_lookup( 'process_group' ),
  $config_dir            = params_lookup( 'config_dir' ),
  $config_file           = params_lookup( 'config_file' ),
  $config_file_mode      = params_lookup( 'config_file_mode' ),
  $config_file_owner     = params_lookup( 'config_file_owner' ),
  $config_file_group     = params_lookup( 'config_file_group' ),
  $config_file_init      = params_lookup( 'config_file_init' ),
  $pid_file              = params_lookup( 'pid_file' ),
  $data_dir              = params_lookup( 'data_dir' ),
  $log_dir               = params_lookup( 'log_dir' ),
  $log_file              = params_lookup( 'log_file' ),
  $port                  = params_lookup( 'port' ),
  $protocol              = params_lookup( 'protocol' )
  ) inherits graylog2::params {

  $bool_create_user=any2bool($create_user)
  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_firewall=any2bool($firewall)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)

  ### Definition of some variables used in the module
  $manage_package = $graylog2::bool_absent ? {
    true  => 'absent',
    false => $graylog2::version,
  }

  $manage_service_enable = $graylog2::bool_disableboot ? {
    true    => false,
    default => $graylog2::bool_disable ? {
      true    => false,
      default => $graylog2::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $graylog2::bool_disable ? {
    true    => 'stopped',
    default =>  $graylog2::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_service_autorestart = $graylog2::bool_service_autorestart ? {
    true    => Class['graylog2::service'],
    false   => undef,
  }

  $manage_file = $graylog2::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $graylog2::bool_absent == true
  or $graylog2::bool_disable == true
  or $graylog2::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  if $graylog2::bool_absent == true
  or $graylog2::bool_disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $graylog2::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $graylog2::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $graylog2::source ? {
    ''        => undef,
    default   => $graylog2::source,
  }

  $manage_file_content = $graylog2::template ? {
    ''        => undef,
    default   => template($graylog2::template),
  }

  $manage_elasticsearchfile_content = $graylog2::elasticsearch_template ? {
    ''        => undef,
    default   => template($graylog2::elasticsearch_template),
  }
  
  ### Internal vars depending on user's input
  $real_install_source = $graylog2::install_source ? {
    ''      => "${graylog2::params::base_url_default}/graylog2-server/releases/download/${graylog2::version}/graylog2-server-${graylog2::version}.tar.gz",
    default => $graylog2::install_source,
  }
  $real_webinterface_install_source = $graylog2::webinterface_install_source ? {
#    ''      => "http://download.graylog2.org/graylog2-server/graylog2-web-interface-${graylog2::version}.tar.gz",
    ''      => "${graylog2::params::base_url_default}/graylog2-web-interface/releases/download/${graylog2::version}/graylog2-web-interface-${graylog2::version}.tar.gz",
    default => $graylog2::install_source,
  }

  $created_dirname = "graylog2-server-${graylog2::version}"
  $webinterface_created_dirname = "graylog2-web-interface-${graylog2::version}"

  $home = "${graylog2::install_destination}/${graylog2::created_dirname}"
  $webinterface_home = "${graylog2::install_destination}/${graylog2::webinterface_created_dirname}"

  $real_config_dir = $graylog2::config_dir ? {
    ''      => $graylog2::install ? {
      package => '/etc/graylog2/',
      default => "${graylog2::home}/config/",
    },
    default => $graylog2::config_dir,
  }

  $real_log_dir = $graylog2::log_dir ? {
    ''      => $graylog2::install ? {
      package => '/var/log/graylog2',
      default => "${graylog2::home}/log",
    },
    default => $graylog2::log_dir,
  }

  $real_log_file = $graylog2::log_file ? {
    ''      => $graylog2::install ? {
      package => '/var/log/graylog2/graylog2-server.log',
      default => "${graylog2::home}/log/graylog2-server.log",
    },
    default => $graylog2::log_file,
  }

  ### Managed resources

  ### DEPENDENCIES class
  if $graylog2::dependencies_class != '' {
    include $graylog2::dependencies_class
  }

  ### Install server if $install is valid
  if $graylog2::install == 'package'
  or $graylog2::install == 'source'
  or $graylog2::install == 'puppi' {

    class { 'graylog2::install':
      require => Class[$graylog2::dependencies_class],
    }

    class { 'graylog2::service':
      require => Class['graylog2::install'],
    }

    class { 'graylog2::config':
      notify => $graylog2::manage_service_autorestart,
    }
  }

  ### Install webinterface if $webinterface_install is valid
  if $graylog2::webinterface_install == 'package'
  or $graylog2::webinterface_install == 'source'
  or $graylog2::webinterface_install == 'puppi' {
    class { 'graylog2::webinterface':
    }
  }

  ### Include custom class if $my_class is set
  if $graylog2::my_class {
    include $graylog2::my_class
  }

  ### Example42 extensions
  if $graylog2::bool_puppi == true
  or $graylog2::bool_monitor == true
  or $graylog2::bool_firewall == true {
    class { 'graylog2::example42': }
  }

  ### Debug
  if $graylog2::bool_debug == true {
    class { 'graylog2::debug': }
  }

}

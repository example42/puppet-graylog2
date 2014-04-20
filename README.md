# Puppet module: graylog2

This is a Puppet module for graylog2 based on the second generation layout ("NextGen") of Example42 Puppet Modules.

Made by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-graylog2

Module development sponsored by [AllOver.IO](http://www.allover.io)

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module (you need it even if you don't use and install Puppi)

For detailed info about the logic and usage patterns of Example42 modules check the DOCS directory on Example42 main modules set.


## USAGE - Basic management

$* Install graylog2 with default settings, that is installation from official site, run as graylog2 user. It installs also the web interface, by default

        class { 'graylog2': }

* Install a specific version of graylog. Applies either to package or source upstream site.

        class { 'graylog2':
          version => '0.11.0',
        }

* Web Interface specific parameters

        class { 'graylog2':
          webinterface_install             => 'package',     # Default: source
          webinterface_package             => 'my-graylog2', # Default: graylog2-web-interface
          webinterface_install_destination => '/usr/local', # Default /opt
          webinterface_webserver           => 'nginx',  # Default (and currently only supported) apache
        }

* Install only graylog2-server without web-interface

        class { 'graylog2':
          webinterface_install => false,     # Default: source
        }

* Install only graylog2-web-interface without graylog2-server

        class { 'graylog2':
          install => false,     # Default: source
        }


* Provide a custom template for elasticsearch configuration file

        class { 'graylog2':
          elasticsearch_path  => 'site/graylog2/elasticsearch.yml.erb',
        }

* Provide mongodb autentication details

        class { 'graylog2':
          mongo_db_host     => 'mongo.example42.com', # Default 127.0.0.1
          mongo_db_port     => '27020', # Default 27017
          mongo_db_name     => 'grey', # Default graylog2
          mongo_user        => 'grey', # Default grayloguser
          mongo_password    => 'mypw', # Default 123 - CHANGE IT!
        }


* Disable graylog2 service.

        class { 'graylog2':
          disable => true
        }

* Remove graylog2 package

        class { 'graylog2':
          absent => true
        }

* Enable auditing without without making changes on existing graylog2 configuration *files*

        class { 'graylog2':
          audit_only => true
        }

* Module dry-run: Do not make any change on *all* the resources provided by the module

        class { 'graylog2':
          noops => true
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file (default template option has to be undefined)

        class { 'graylog2':
          template => undef,
          source  => [ "puppet:///modules/example42/graylog2/graylog2.conf-${hostname}" , "puppet:///modules/example42/graylog2/graylog2.conf" ],
        }


* Use custom template for main config file, alternative to default template

        class { 'graylog2':
          template => 'example42/graylog2/graylog2.conf.erb',
        }

* Automatically include a custom subclass

        class { 'graylog2':
          my_class => 'example42::my_graylog2',
        }


## USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)

        class { 'graylog2':
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with a puppi::helper define ) to customize the output of puppi commands 

        class { 'graylog2':
          puppi        => true,
          puppi_helper => 'myhelper', 
        }

* Activate automatic monitoring (recommended, but disabled by default). This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { 'graylog2':
          monitor      => true,
          monitor_tool => [ 'nagios' , 'monit' , 'munin' ],
        }

* Activate automatic firewalling. This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { 'graylog2':       
          firewall      => true,
          firewall_tool => 'iptables',
          firewall_src  => '10.42.0.0/24',
          firewall_dst  => $ipaddress_eth0,
        }


## CONTINUOUS TESTING

Travis {<img src="https://travis-ci.org/example42/puppet-graylog2.png?branch=master" alt="Build Status" />}[https://travis-ci.org/example42/puppet-graylog2]

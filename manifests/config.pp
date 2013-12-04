# Class: graylog2::config
#
# This class manages graylog2 configuration
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
class graylog2::config {

  file { 'graylog2.conf':
    ensure  => $graylog2::manage_file,
    path    => $graylog2::config_file,
    mode    => $graylog2::config_file_mode,
    owner   => $graylog2::config_file_owner,
    group   => $graylog2::config_file_group,
    source  => $graylog2::manage_file_source,
    content => $graylog2::manage_file_content,
    replace => $graylog2::manage_file_replace,
    audit   => $graylog2::manage_audit,
    noop    => $graylog2::noops,
  }

  file { 'elasticsearch.yml':
    ensure  => $graylog2::manage_file,
    path    => $graylog2::elasticsearch_path,
    mode    => $graylog2::config_file_mode,
    owner   => $graylog2::config_file_owner,
    group   => $graylog2::config_file_group,
    content => $graylog2::manage_elasticsearchfile_content,
    replace => $graylog2::manage_file_replace,
    audit   => $graylog2::manage_audit,
    noop    => $graylog2::noops,
  }


  # The whole graylog2 configuration directory can be recursively overriden
  if $graylog2::source_dir {
    file { 'graylog2.dir':
      ensure  => directory,
      path    => $graylog2::real_config_dir,
      source  => $graylog2::source_dir,
      recurse => true,
      purge   => $graylog2::bool_source_dir_purge,
      force   => $graylog2::bool_source_dir_purge,
      replace => $graylog2::manage_file_replace,
      audit   => $graylog2::manage_audit,
      noop    => $graylog2::noops,
    }
  }

}

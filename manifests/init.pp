# == Class: carbon_c_relay
#
# Installs, configures and manages carbon-c-relay service.
# Carbon-c-relay is an enhanced C implementation of Carbon relay, aggregator
# and rewriter.
#
# === Parameters
#
# [*allowed_chars*]
# Specifies the allowed chars next to [A-Za-z0-9]
# Default: [-_:#]
#
# [*carbon_cache_statistics*]
# Specifies to send statistics like carbon-cache.py, e.g. not cumulative
#
# [*config_clusters*]
# Specifies what clusters are added to the config file
#
# [*config_file*]
# Specifies where carbon-c-relay reads it's config settings.
#
# [*config_matches*]
# Specifies what match rules are added to the config file
#
# [*config_rewrites*]
# Specifies what rewrite rules are added to the config file
#
# [*io_timeout*]
# Specifies IO timeout in milliseconds for server connections
# Default: 600
#
# [*init_file*]
# Specifies the name of the init file
#
# [*init_file_ensure*]
# Specifies whether the init file should exist, and if so what kind.
# Default value: present
#
# [*init_template*]
# Specifies the path of the template that is used.
#
# [*init_string*]
# Specifies the systemd init string
#
# [*init_template*]
# Specifies the systemd init template
#
# [*interface*]
# Specify on which interface (or all interfaces) carbon-c-relay should listen.
# Removed in carbon-c-relay 3.2
#
# [*listen_backlog*]
# Specify connection listen backlog
# Default: 3 (<v2.2), 32 (v2.2)
#
# [*listen*]
# Specify on which port carbon-c-relay should listen.
#
# [*max_stalls*]
# Specify server max stalls
# Default: 4
#
# [*ouput_file*]
# Specify to which file carbon-c-relay should redirect its output
#
# [*package_ensure*]
#   Specifies what state the package should be in.
#   Valid values: present, installed, absent, purged, held, latest.
#   Defaults to: present
#
# [*package_manage*]
#   Specify if the package should be managed by this module.
#   Defaults to: true
#
# [*package_name*]
#   Specify the name this package.
#   Defaults to: 'carbon-c-relay'.
#
# [*pid_dir*]
#   Specifies directory where the pid file is written.
#   Default: /var/run/carbon-c-relay
#
# [*pid_file*]
#   Specifies name of pid file
#   Default: carbon-c-relay.pid
#
# [*replication_factor*]
#   Indicates the replication factor the relay is going to use
#
# [*server_batch_size*]
#
# [*server_queue_size*]
#
# [*service_enable*]
#   Specify if the service should be enabled to start at boot.
#   Valid values: true, false, manual, mask.
#   Defaults to: true
#
# [*service_ensure*]
#   Specify if the service should be running.
#   Valid values: stopped, running.
#   Defaults to: 'running'
#
# [*service_manage*]
#   Specify if the service should be managed by this module.
#   Defaults to: true
#
# [*service_name*]
#   Specifies the name of the service to run
#   Defaults to: 'ccrelay'
#
# [*sorted_matches*]
#   Indicates whether match rules in conf should be sorted
#   Defaults to: true
#
# [*sorted_rewrites*]
#   Indicates whether rewrite rules in conf should be sorted
#   Defaults to: false
#
# [*statistics_hostname*]
# Specify to override hostname used in statistics
#
# [*statistics_sending_interval*]
# Specify the number of seconds between sending data.
# Removed in carbon-c-relay 3.2
#
# [*worker_threads*]
#
# === Examples
#
# * Installation, make sure service is running and will be started at boot time:
#  class { 'carbon_c_relay': }
#
# === Authors
#
# Marc Lambrichs <marc.lambrichs@gmail.com>
#
class carbon_c_relay (
  $allowed_chars               = $carbon_c_relay::params::allowed_chars,
  $carbon_cache_statistics     = $carbon_c_relay::params::carbon_cache_statistics,
  $config_clusters             = $carbon_c_relay::params::config_clusters,
  $config_file                 = $carbon_c_relay::params::config_file,
  $config_matches              = $carbon_c_relay::params::config_matches,
  $config_rewrites             = $carbon_c_relay::params::config_rewrites,
  $group                       = $carbon_c_relay::params::group,
  $io_timeout                  = $carbon_c_relay::params::io_timeout,
  $init_file                   = $carbon_c_relay::params::init_file,
  $init_file_ensure            = $carbon_c_relay::params::init_file_ensure,
  $init_template               = $carbon_c_relay::params::init_template,
  $interface                   = $carbon_c_relay::params::interface,
  $limit_fsize                 = $carbon_c_relay::params::limit_fsize,
  $limit_cpu                   = $carbon_c_relay::params::limit_cpu,
  $limit_as                    = $carbon_c_relay::params::limit_as,
  $limit_no_file               = $carbon_c_relay::params::limit_no_file,
  $limit_nproc                 = $carbon_c_relay::params::limit_nproc,
  $listen                      = $carbon_c_relay::params::listen,
  $listen_backlog              = $carbon_c_relay::params::listen_backlog,
  $log_dir                     = $carbon_c_relay::params::log_dir,
  $log_file                    = $carbon_c_relay::params::log_file,
  $max_stalls                  = $carbon_c_relay::params::max_stalls,
  $output_file                 = $carbon_c_relay::params::output_file,
  $package_ensure              = $carbon_c_relay::params::package_ensure,
  $package_manage              = $carbon_c_relay::params::package_manage,
  $package_name                = $carbon_c_relay::params::package_name,
  $pid_dir                     = $carbon_c_relay::params::pid_dir,
  $pid_file                    = $carbon_c_relay::params::pid_file,
  $replication_factor          = $carbon_c_relay::params::replication_factor,
  $server_batch_size           = $carbon_c_relay::params::server_batch_size,
  $server_queue_size           = $carbon_c_relay::params::server_queue_size,
  $service_enable              = $carbon_c_relay::params::service_enable,
  $service_ensure              = $carbon_c_relay::params::service_ensure,
  $service_file                = $carbon_c_relay::params::service_file,
  $service_manage              = $carbon_c_relay::params::service_manage,
  $service_name                = $carbon_c_relay::params::service_name,
  $service_template            = $carbon_c_relay::params::service_template,
  $statistics_hostname         = $carbon_c_relay::params::statistics_hostname,
  $statistics_sending_interval = $carbon_c_relay::params::statistics_sending_interval,
  $sorted_matches              = $carbon_c_relay::params::sorted_matches,
  $sorted_rewrites             = $carbon_c_relay::params::sorted_rewrites,
  $sysconfig_file              = $carbon_c_relay::params::sysconfig_file,
  $sysconfig_template          = $carbon_c_relay::params::sysconfig_template,
  $user                        = $carbon_c_relay::params::user,
  $user_shell                  = $carbon_c_relay::params::usershell,
  $worker_threads              = $carbon_c_relay::params::worker_threads
) inherits carbon_c_relay::params {

  validate_bool(
    $carbon_cache_statistics,
    $package_manage,
    $service_enable,
    $service_manage,
    $sorted_matches,
    $sorted_rewrites,
  )

  validate_hash(
    $config_clusters,
    $config_rewrites,
  )

  validate_integer([
    $io_timeout,
    $limit_no_file,
    $limit_nproc,
    $listen,
    $listen_backlog,
    $max_stalls,
    $replication_factor,
    $server_batch_size,
    $server_queue_size,
    $statistics_sending_interval,
    $worker_threads,
  ])

  validate_string(
    $config_file,
    $group,
    $init_file,
    $init_file_ensure,
    $init_template,
    $interface,
    $log_dir,
    $log_file,
    $output_file,
    $package_ensure,
    $package_name,
    $pid_dir,
    $pid_file,
    $service_ensure,
    $service_name,
    $sysconfig_file,
    $sysconfig_template,
    $user,
  )

  anchor { 'carbon_c_relay::begin': }
  -> class { '::carbon_c_relay::install': }
  -> class { '::carbon_c_relay::config': }
  ~> class { '::carbon_c_relay::service': }
  -> anchor { 'carbon_c_relay::end': }
}

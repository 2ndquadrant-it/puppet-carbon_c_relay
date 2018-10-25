#
class carbon_c_relay::config (
  $allowed_chars               = $carbon_c_relay::allowed_chars,
  $carbon_cache_statistics     = $carbon_c_relay::carbon_cache_statistics,
  $config_file                 = $carbon_c_relay::config_file,
  $group                       = $carbon_c_relay::group,
  $io_timeout                  = $carbon_c_relay::io_timeout,
  $interface                   = $carbon_c_relay::interface,
  $listen                      = $carbon_c_relay::listen,
  $listen_backlog              = $carbon_c_relay::listen_backlog,
  $log_dir                     = $carbon_c_relay::log_dir,
  $log_file                    = $carbon_c_relay::log_file,
  $max_stalls                  = $carbon_c_relay::max_stalls,
  $package_name                = $carbon_c_relay::package_name,
  $pid_dir                     = $carbon_c_relay::pid_dir,
  $pid_file                    = $carbon_c_relay::pid_file,
  $replication_factor          = $carbon_c_relay::replication_factor,
  $server_batch_size           = $carbon_c_relay::server_batch_size,
  $server_queue_size           = $carbon_c_relay::server_queue_size,
  $service_name                = $carbon_c_relay::service_name,
  $sorted_matches              = $carbon_c_relay::sorted_matches,
  $sorted_rewrites             = $carbon_c_relay::sorted_rewrites,
  $statistics_hostname         = $carbon_c_relay::statistics_hostname,
  $statistics_sending_interval = $carbon_c_relay::statistics_sending_interval,
  $sysconfig_file              = $carbon_c_relay::sysconfig_file,
  $sysconfig_template          = $carbon_c_relay::sysconfig_template,
  $user                        = $carbon_c_relay::user,
  $worker_threads              = $carbon_c_relay::worker_threads,
) {
  file { $sysconfig_file:
    ensure  => file,
    content => template($sysconfig_template),
    notify  => Service[$service_name]
  }

  concat { $config_file:
    ensure => present,
    owner  => $user,
    group  => $group,
    mode   => '0644',
    notify => Service[$service_name]
  }

  ### Set header for config
  concat::fragment { 'header':
    target  => $config_file,
    order   => '01',
    content => "### ${config_file}: Managed by Puppet."
  }

  $cluster_defaults = {
    replication_factor => $replication_factor
  }

  ### Count the number of clusters and match rules for giving a proper order
  ### to matches and rewrites.
  $nr_of_clusters = count(keys($carbon_c_relay::config_clusters))
  $nr_of_matches  = count(keys($carbon_c_relay::config_matches))

  create_resources( 'carbon_c_relay::config::cluster', $carbon_c_relay::config_clusters, $cluster_defaults )
  ### Sort match rules
  if $sorted_matches {
    $matches = carbon_c_relay_sorted( $carbon_c_relay::config_matches,
                  $nr_of_clusters + 1 )
  } else {
    $matches = $carbon_c_relay::config_matches
  }

  create_resources( 'carbon_c_relay::config::match', $matches )

  ### Sort rewrite rules
  if $sorted_rewrites {
    $rewrites = carbon_c_relay_sorted( $carbon_c_relay::config_rewrites,
                  $nr_of_clusters + $nr_of_matches + 1 )
  } else {
    $rewrites = $carbon_c_relay::config_rewrites
    $rewrite_defaults = { order => $nr_of_clusters + $nr_of_matches + 1 }
  }

  create_resources('carbon_c_relay::config::rewrite', $rewrites, $rewrite_defaults)

  Carbon_c_relay::Config::Cluster<| |>
  -> Carbon_c_relay::Config::Match<| |>
  -> Carbon_c_relay::Config::Rewrite<| |>

}

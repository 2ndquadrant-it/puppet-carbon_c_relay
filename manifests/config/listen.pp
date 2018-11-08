#
define carbon_c_relay::config::listen (
  $transport   = undef,
  $ssl_pemcert = undef,
  $interfaces  = []
){

  unless is_array( $interfaces ) {
    fail("'interfaces' param is not a array")
  }

  concat::fragment { "listen-${title}":
    target  => $carbon_c_relay::config_file,
    content => template('carbon_c_relay/config/listen.erb'),
    order   => '99',
  }
}

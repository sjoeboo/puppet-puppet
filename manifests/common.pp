# document me
class puppet::common(
  $agent             = $::puppet::agent,
  $ca_server         = $::puppet::ca_server,
  $certname          = $::puppet::server_certname,
  $ensure            = $::puppet::ensure,
  $server            = $::puppet::server,
  $srv_domain        = $::puppet::srv_domain,
  $use_srv_records   = $::puppet::use_srv_records,
  $dns_alt_names     = $::puppet::dns_alt_names,
  $agent_config_path = $::puppet::agent_config_path,
) {

  concat { "${agent_config_path}puppet.conf":
    ensure => $ensure,
  }

  concat::fragment { 'puppet_main':
    target  => "${agent_config_path}puppet.conf",
    content => template("${module_name}/puppet.main.erb"),
    order   => '01',
  }

  file { "${agent_config_path}auth.conf":
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template("${module_name}/auth.conf.erb"),
  }

}

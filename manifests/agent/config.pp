# document me
class puppet::agent::config (
  $agent              = $::puppet::agent,
  $agent_config_path  = $::puppet::agent_config_path,
  $env                = $::puppet::env,
  $use_srv_records    = $::puppet::use_srv_records,
  $puppetmaster       = $::puppet::puppetmaster,
  $runinterval        = $::puppet::runinterval,
  $splay              = $::puppet::splay,
  $splaylimit         = $::puppet::splaylimit,
) {

  if $env == undef {
    $env_real = $::environment
  }
  else {
    $env_real = $env
  }

  concat::fragment { 'puppet_agent':
    target  => "${agent_config_path}puppet.conf",
    content => template("${module_name}/puppet.agent.erb"),
    order   => '05',
  }

  if $::osfamily == 'Debian' {
    if $agent {
      $start = 'yes'
    } else {
      $start = 'no'
    }

    file { '/etc/default/puppet':
      content => inline_template('START=<%= @start %>'),
    }
  }
}

# document me
class puppet::agent::service (
  $runmode = $::puppet::runmode,
  $agent_path = $::puppet::agent_path,
  $cron_cmd_pre = $::puppet::cron_cmd_pre,
  $cron_cmd = $::puppet::cron_cmd,
){

  if ( $::puppet::agent ) {
    $mode = $runmode
  } else {
    $mode = 'none'
  }

  case $runmode {
    'cron': {
      $sleep_sec = fqdn_rand(59)

      cron { 'puppet':
        ensure  => 'present',
        user    => 'root',
        command => "${cron_cmd_pre} sleep ${sleep_sec} ${agent_path}${cron_cmd}",
        hour    => '*',
        minute  =>  [ fqdn_rand(30), fqdn_rand(30) + 30 ],
      }

      service { 'puppet':
        ensure => 'stopped',
        enable => false,
      }
    }
    'service': {
      cron { 'puppet':
        ensure => 'absent',
      }

      service { 'puppet':
        ensure => 'running',
        enable => true,
      }
    }
    'none': {
      cron { 'puppet':
        ensure => 'absent',
      }

      service { 'puppet':
        ensure => 'stopped',
        enable => false,
      }
    }
    default: {
      fail("Unsupported runmode ${runmode} in puppet::agent::service")
    }
  }
}

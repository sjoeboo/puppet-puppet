class puppet::agent::install (
  Boolean $agent         = $::puppet::agent,
  String  $agent_version = $::puppet::agent_version,
  String  $agent_pkg     = $::puppet::agent_pkg,

){

  # puppetserver depends on agent, don't remove it if agent is false
  if $agent {
    package { $agent_pkg:
      ensure  => $agent_version,
    }
  }

}

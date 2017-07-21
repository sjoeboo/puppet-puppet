# document me
class puppet::params {

  $agent_version = 'latest'
  $agent_pkg  = 'puppet-agent'
  $agent_path = '/opt/puppetlabs/bin/'
  $agent_config_path = '/etc/puppetlabs/puppet/'
  $agent_rundir = undef
  $ca_server = undef
  $use_srv_records = false
  $srv_domain = undef
  $runmode = 'cron'
  $env = undef
  $puppetmaster = "puppet.${::domain}"
  $splay = false
  $splaylimit = undef
  $agent_config_hash = {}
  $cron_cmd_pre = 'MAILTO=""'
  $cron_cmd = 'puppet agent --onetime --no-daemonize'

  $autosign = '/etc/puppetlabs/puppet/autosign.conf'
  $autosign_runnable = false
  $autosign_list     = []
  $autosign_script   = undef
  $dns_alt_names = undef
  $fileserver_conf = undef
  $manage_hiera = true
  $hiera_source = undef
  $puppetdb = false
  $puppetdb_port = 8081
  $puppetdb_server = undef
  $puppetdb_version = 'latest'
  $manage_puppetdb = true
  $runinterval = '30m'
  $server_ca_enabled = true
  $server_certname = undef
  $server_java_opts = '-Xms2g -Xmx2g -XX:MaxPermSize=256m'
  $server_log_dir = '/var/log/puppetlabs/puppetserver'
  $server_log_file = 'puppetserver.log'
  $server_reports = undef
  $server_version = 'latest'
  $firewall = false
  $jruby_instances = $::processorcount - 1
  $use_legacy_auth = false
  $server_ssl_cert = undef
  $server_ssl_key = undef
  $server_ssl_ca_cert = undef
  $server_ssl_cert_chain = undef
  $server_ssl_crl_path = undef
  $admin_whitelist  = undef
  $webserver_opts = undef


  case $::osfamily {
    'Debian': {
      $server_config_dir = '/etc/default'
    }
    'RedHat': {
      $server_config_dir = '/etc/sysconfig'
    }
    default: {
      fail("${::osfamily} is not supported.")
    }
  }
}

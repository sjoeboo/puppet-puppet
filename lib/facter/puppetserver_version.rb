#!/usr/bin/env ruby

require 'facter'

begin
  Facter.operatinsystem
rescue
  Facter.loadfacts()
end

#If puppetserver is installed..
if File.exists?('/opt/puppetlabs/bin/puppetserver')
  puppetserver_version = `/opt/puppetlabs/bin/puppetserver --version`.split(':')[1].chomp.strip
  Facter.add('puppetserver_version') do
    setcode do
      puppetserver_version
    end
  end
end

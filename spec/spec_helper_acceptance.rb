require 'beaker-rspec'
require 'beaker/puppet_install_helper'

run_puppet_install_helper unless ENV['BEAKER_provision'] == 'no'

RSpec.configure do |c|
  module_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.formatter = :documentation

  c.before :suite do
    puppet_module_install(source: module_root, module_name: 'fluentd')

    hosts.each do |host|
      on host, puppet('module', 'install', 'puppetlabs-stdlib')
      on host, puppet('module', 'install', 'puppetlabs-apt')
      on host, puppet('module', 'install', 'puppetlabs-yumrepo_core')
    end
  end
end

#
# Cookbook:: elk5
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


node.default['java']['oracle']['accept_oracle_download_terms'] = true
node.default['java']['jdk_version'] = 8
node.default['java']['install_flavor'] = 'oracle'
include_recipe 'java'

elasticsearch_user 'elasticsearch'

elasticsearch_install 'elasticsearch' do
  type 'package'
  version '5.2.2'
end

elasticsearch_configure 'elasticsearch'

elasticsearch_service 'elasticsearch'

service 'elasticsearch' do
  supports status: true, restart: true, reload: true
  action [:start]
end

include_recipe 'kibana5'
kibana5_install 'kibana'

kibana5_configure 'kibana' do
  configuration 'server.port' => node['kibana5']['config']['server.port'],
                'server.host' => node['kibana5']['config']['server.host'],
                'elasticsearch.url' => node['kibana5']['config']['elasticsearch.url'],
                'logging.dest' => node['kibana5']['config']['logging.dest']
end

node.set['logstash']['version']='5.2.2'
node.set['logstash']['download_url']='https://artifacts.elastic.co/downloads/logstash/logstash-5.2.2.tar.gz'
node.set['logstash']['checksum']='e5b6c70ccae7eec6410468ad7cec4e418378b3d31175441ccb2d7bc586637d6f'

include_recipe 'simple-logstash::default'
logstash_service 'logstash'

# example config requires special permissions to read logfile
group 'adm' do
  action :modify
  members 'logstash'
  append true
end
logstash_input 'syslog'
logstash_output 'logstash'

# initialize logstash / kibana with an initial log message
#file '/var/run/elk-stack.firstrun' do
#  notifies :restart, 'logstash_service[logstash]', :immediately
#  notifies :restart, 'runit_service[kibana]', :immediately
#  notifies :run, 'execute[first-log]', :delayed
#end

execute 'first-log' do
  command 'sleep 5 && logger -p local0.info "very first log message to kick things off"'
  action :nothing
end

#
# Cookbook Name:: crake
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute 'Add Crake source' do
  command "gem sources --add #{node['crake']['gem_source']}"
end

execute 'Install Crake' do
	command "gem install crake"
end
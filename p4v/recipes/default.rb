#
# Cookbook Name:: p4v
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'boxstarter::default'

boxstarter "boxstarter run" do

  # retries 3
  password 'vagrant'
  disable_reboots true

  code <<-EOH
    choco install p4v
  EOH
end
#
# Cookbook Name:: ccrx
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'windows'

windows_package 'CCRX V2.03.00' do
  package_name 'Renesas RX Compiler V2.03.00'
  source 'c:/vagrant/CC-RX_V20300_setup.exe'
  installer_type :installshield
  action :install
end

windows_package 'Renesas License Manager' do
  package_name 'Renesas License Manager'
  source 'c:/vagrant/LicenseManager_setup.exe'
  installer_type :installshield
  action  :install
end

# Add ccrx bin directory to path.
# Note: An alternative method is the Opscode Windows Cookbook windows_path 
# resource (commented below), but it doesn't seem to work 100% of the time.
execute 'set ccrx_path' do
  command "setx -m PATH \"%PATH%;C:\\Program Files (x86)\\Renesas\\RX\\2_3_0\\bin\""
end

#windows_path 'C:\Program Files (x86)\Renesas\RX\2_3_0\bin' do
#   action :add
# end

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
  source 'http://am.renesas.com/support/downloads/jq_download_category/ide/CC-RX_V20300_setup.exe'
  installer_type :installshield
  action :install
end

windows_package 'Renesas License Manager' do
  package_name 'Renesas License Manager'
  source 'http://am.renesas.com/support/downloads/jq_download_category/ide/LicenseManager_setup.exe'
  installer_type :installshield
  action  :install
end
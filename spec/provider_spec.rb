require 'spec_helper'
require 'chefspec'
require_relative '../libraries/check_process_tree'

describe 'boxstarter provider' do
  
  let(:chef_run) do
  	ChefSpec::Runner.new(
  		cookbook_path: ["#{File.dirname(__FILE__)}/../..","#{File.dirname(__FILE__)}/cookbooks"], 
  		step_into: ['boxstarter']
  		) do | node |
      node.set['boxstarter']['tmp_dir'] = '/boxstarter/tmp'
      node.automatic['platform_family'] = 'windows'
  	end.converge('boxstarter_test::default')
  end
  before do
    require 'win32ole'
    allow(WIN32OLE).to receive(:connect).with("winmgmts://").and_return(
      Boxstarter::SpecHelper::MockWMI.new([]))
  end

  it "creates temp directory" do
    expect(chef_run).to create_directory('/boxstarter/tmp')
  end
  it "copies boxstarter installer" do
    expect(chef_run).to create_cookbook_file('/boxstarter/tmp/bootstrapper.ps1')
  end
  it "writes installer wrapper" do
    expect(chef_run).to create_template('/boxstarter/tmp/setup.bat').with(
      source: "ps_wrapper.erb",
      variables: {
        :command => "-command \". '%~dp0bootstrapper.ps1';Get-Boxstarter -force\""})
  end
  it "executes the installer" do
    expect(chef_run).to run_execute('/boxstarter/tmp/setup.bat')
  end
  it "writes code to package file" do
    expect(chef_run).to create_template('/boxstarter/tmp/package.ps1').with(
      source: "package.erb",
      cookbook: "boxstarter",
      variables: {
        :code => "Install-WindowsUpdate -acceptEula",
        :start_chef_client_onreboot => true})
  end
  it "writes command file with the correct parameters" do
    expect(chef_run).to create_template('/boxstarter/tmp/boxstarter.ps1').with(
      source: "boxstarter_command.erb",
      cookbook: "boxstarter",
      variables: {
        :password => nil,
        :disable_boxstarter_restart => false,
        :is_remote => false,
        :temp_dir => "/boxstarter/tmp",
        :disable_reboots => false})
  end  
  it "writes the wrapper file" do
    expect(chef_run).to create_template('/boxstarter/tmp/boxstarter.bat').with(
      source: "ps_wrapper.erb",
      cookbook: "boxstarter",
      variables: {:command => "-file /boxstarter/tmp/boxstarter.ps1"})
  end
  it "executes the wrapper" do
    expect(chef_run).to run_execute('/boxstarter/tmp/boxstarter.bat')
  end
end
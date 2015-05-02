# Notes:
# 1. Eclipse has been forced to a 32-bit installation for compatibility with Renesas plugins.
# 2. Eclipse installation directory has been specified by Chef attribute so that the Eclipse p2 director 
#    application is in a known location in case the chocolatey package maintainers change the
#    default install location.
# 3. Eclipse version has been specified by Chef attribute to prevent updates to the chocolatey package from breaking this
#    recipe.

raise if node['eclipse']['version'].empty? || node['eclipse']['dir'].empty?

include_recipe 'boxstarter::default'

# Test

boxstarter "boxstarter run" do

  retries 3
  password 'vagrant'

  # Install-ChocolateyInstallPackage 
  # code <<-EOH
  #   cinst eclipse -source C:\vagrant -version #{node['eclipse']['version']} -x86
  # EOH
  code <<-EOH
    cinst chrome
  EOH
end

include_recipe 'boxstarter::default'

boxstarter "boxstarter run" do
  password 'vagrant'
  code <<-EOH
    cinst eclipse
  EOH
end

include_recipe 'boxstarter::default'

boxstarter "boxstarter run" do
  retries 3
  password 'vagrant'
  code <<-EOH
    cinst eclipse
  EOH
end

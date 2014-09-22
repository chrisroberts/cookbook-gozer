include_recipe 'gozer'

chef_gem 'ruby-shadow'

user node[:gozer][:username] do
  home "/home/#{node[:gozer][:username]}"
  password node[:gozer][:password]
  shell node[:gozer][:shell] || '/bin/bash'
  supports :manage_home => true
end

node[:gozer][:groups].each do |grp|
  group grp do
    members Array(node[:gozer][:username])
  end
end

cookbook_file "/home/#{node[:gozer][:username]}/.bash_profile" do
  source 'bash_profile'
  owner node[:gozer][:username]
  group node[:gozer][:username]
  mode 0644
end

cookbook_file "/home/#{node[:gozer][:username]}/.bashrc" do
  source 'bashrc'
  owner node[:gozer][:username]
  group node[:gozer][:username]
  mode 0644
end

package 'i3'

remote_directory "/home/#{node[:gozer][:username]}/.i3" do
  source "i3"
  action :create
  owner node[:gozer][:username]
  group node[:gozer][:username]
  files_mode 0644
end

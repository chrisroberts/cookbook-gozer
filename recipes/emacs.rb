package node[:gozer][:emacs][:package_name]

directory "/home/#{node[:gozer][:username]}/.emacs.d" do
  owner node[:gozer][:username]
  group node[:gozer][:username]
end

template "/home/#{node[:gozer][:username]}/.emacs.d/init.el" do
  source 'emacs.init.el.erb'
  owner node[:gozer][:username]
  group node[:gozer][:username]
end

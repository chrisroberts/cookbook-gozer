package 'irssi'

irssi_config = Gozer.bag('gozer', 'irssi', node[:gozer][:bag_secret])

if(irssi_config)
  directory "/home/#{node[:gozer][:username]}/.irssi" do
    owner node[:gozer][:username]
    group node[:gozer][:username]
    action :create
  end

  file "/home/#{node[:gozer][:username]}/.irssi/config" do
    content irssi_config['content']
    owner node[:gozer][:username]
    group node[:gozer][:username]
  end
end

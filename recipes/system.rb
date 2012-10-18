include_recipe 'apt'

file '/etc/hostname' do
  content node[:gozer][:hostname]
  mode 0644
end

execute 'go go gadget upgrade' do
  command 'apt-get -q -y upgrade'
  action :nothing
  subscribes :run, resources(:execute => 'apt-get-update-periodic'), :delayed
end

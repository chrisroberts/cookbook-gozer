package 'openvpn'

%w(vpns vpns/openvpn).each do |dir|
  directory "/home/#{node[:gozer][:username]}/#{dir}" do
    action :create
    owner node[:gozer][:username]
    group node[:gozer][:username]
  end
end

openvpns = gozer_bag('openvpn')

openvpns.each do |name, data|
  directory "/home/#{node[:gozer][:username]}/vpns/openvpn/#{name}" do
    action :create
    owner node[:gozer][:username]
    group node[:gozer][:username]
  end

  data.each do |filename, file_content|
    file "/home/#{node[:gozer][:username]}/vpns/openvpn/#{name}/#{filename}" do
      content file_content
      owner node[:gozer][:username]
      group node[:gozer][:username]
    end
  end
end



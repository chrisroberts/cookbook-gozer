chef_gem 'ruby-shadow'

user node[:gozer][:username] do
  home "/home/#{node[:gozer][:username]}"
  password node[:gozer][:password]
  shell node[:gozer][:shell] || '/bin/bash'
  supports :manage_home => true
end

%w(adm dialout cdrom plugdev lpadmin admin sambashare nopass).each do |grp|
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

bag = gozer_bag('ssh_keys')

directory "/home/#{node[:gozer][:username]}/.ssh" do
  action :create
  owner node[:gozer][:username]
  group node[:gozer][:username]
  mode 0755
end

bag['keys'].each do |file_name, file_content|
  file "/home/#{node[:gozer][:username]}/.ssh/#{file_name}" do
    content file_content
    owner node[:gozer][:username]
    group node[:gozer][:username]
    mode 0600
  end
end

remote_directory "/home/#{node[:gozer][:username]}/bin" do
  source 'bin'
  action :create
  owner node[:gozer][:username]
  group node[:gozer][:username]
  files_mode 0755
end

chef_bag = gozer_bag('chef')

if(chef_bag)
  directory "/home/#{node[:gozer][:username]}/.chef" do 
    action :create
    owner node[:gozer][:username]
    group node[:gozer][:username]
  end
  chef_bag['files'].each do |name, f_content|
    file "/home/#{node[:gozer][:username]}/.chef/#{name}" do
      content f_content
      owner node[:gozer][:username]
      group node[:gozer][:username]
      mode 0600
    end
  end
end

%w(.config .config/Terminal).each do |item|
  directory "/home/#{node[:gozer][:username]}/#{item}" do
    action :create
    owner node[:gozer][:username]
    group node[:gozer][:username]
    mode 0755
  end
end

cookbook_file "/home/#{node[:gozer][:username]}/.config/Terminal/terminalrc" do
  source 'terminalrc'
  mode 0644
  owner node[:gozer][:username]
  group node[:gozer][:username]
end

directory "/home/#{node[:gozer][:username]}/Projects" do
  action :create
  owner node[:gozer][:username]
  group node[:gozer][:username]
end

node[:gozer][:projects][:git].each do |k,v|
  if(v && File.dirname(v) != '.')
    File.dirname(v).split('/').inject("/home/#{node[:gozer][:username]}/Projects") do |memo, obj|
      memo << "/#{obj}"
      directory memo do
        action :create
        mode 0755
        owner node[:gozer][:username]
        group node[:gozer][:username]
      end
      memo
    end
  end
  execute "clone #{k}" do
    command "git clone #{k} #{File.join("/home/#{node[:gozer][:username]}/Projects", v) if v}"
    cwd "/home/#{node[:gozer][:username]}/Projects"
    user node[:gozer][:username]
    group node[:gozer][:username]
    not_if do
      p_dir = v || File.basename(k).sub('.git', '')
      File.directory?("/home/#{node[:gozer][:username]}/Projects/#{p_dir}")
    end
  end
end

if(node[:gozer][:opscode][:user])
  file '/etc/chef/opscode_user' do
    content node[:gozer][:opscode][:user]
    mode 0644
  end
end

include_recipe 'gozer::git'

package 'pidgin'

directory '/opt/custom_packages' do
  action :create
end

remote_file "/opt/custom_packages/#{File.basename(node[:gozer][:skype_package])}" do
  source node[:gozer][:skype_package]
  action :create_if_missing
end

execute 'skype[install deb]' do
  command "dpkg -i /opt/custom_packages/#{File.basename(node[:gozer][:skype_package])}; apt-get -f -y install"
  creates "/usr/bin/skype"
end

package 'finch'
package 'pidgin-skype'

skype_config = Gozer.bag('gozer', 'skype', node[:gozer][:bag_secret])

if(skype_config)
  directory "/home/#{node[:gozer][:username]}/.Skype" do
    action :create
    owner node[:gozer][:username]
    group node[:gozer][:username]
  end

  directory "/home/#{node[:gozer][:username]}/.Skype/#{skype_config['username']}" do
    action :create
    owner node[:gozer][:username]
    group node[:gozer][:username]
  end

  file "/home/#{node[:gozer][:username]}/.Skype/#{skype_config['username']}/config.xml" do
    content skype_config[:content]
    owner node[:gozer][:username]
    group node[:gozer][:username]
  end
end

purple_config = Gozer.bag('gozer', 'purple', node[:gozer][:bag_secret])

if(purple_config)
  directory "/home/#{node[:gozer][:username]}/.purple" do
    action :create
    owner node[:gozer][:username]
    group node[:gozer][:username]
  end

  purple_config['files'].each do |file_name, file_contents|
    file "/home/#{node[:gozer][:username]}/.purple/#{file_name}" do
      content file_contents
      owner node[:gozer][:username]
      group node[:gozer][:username]
    end
  end
end

package 'libpurple-dev'

execute "campfire-libpurple[fetch]" do
  command "git clone git://github.com/jrfoell/campfire-libpurple.git /opt/custom_packages/campfire-libpurple"
  creates "/opt/custom_packages/campfire-libpurple"
end

execute "campfire-libpurple[build]" do
  command "make"
  cwd "/opt/custom_packages/campfire-libpurple"
  creates "/opt/custom_packages/campfire-libpurple/libcampfire.so"
end

execute "campfire-libpurple[install]" do
  command "cp /opt/custom_packages/campfire-libpurple/libcampfire.so /usr/lib/pidgin/libcampfire.so"
  creates "/usr/lib/pidgin/libcampfire.so"
end

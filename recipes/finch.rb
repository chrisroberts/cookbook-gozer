include_recipe 'gozer::git'

package 'pidgin'

directory node[:gozer][:custom_packages] do
  action :create
end

skype_package_path = File.join(node[:gozer][:custom_packages], File.basename(node[:gozer][:skype_package]))

remote_file skype_package_path do
  source node[:gozer][:skype_package]
  action :create_if_missing
end

execute 'skype[install deb]' do
  command "dpkg -i #{skype_package_path}; apt-get -f -y install"
  creates "/usr/bin/skype"
end

package 'finch'
package 'pidgin-skype'

skype_config = gozer_bag('skype')

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

purple_config = gozer_bag('purple')

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

camp_dir = File.join(node[:gozer][:custom_packages], 'campfire-libpurple')

execute "campfire-libpurple[fetch]" do
  command "git clone git://github.com/jrfoell/campfire-libpurple.git #{camp_dir}"
  creates camp_dir
end

execute "campfire-libpurple[build]" do
  command "make"
  cwd camp_dir
  creates File.join(camp_dir, 'libcampfire.so')
end

execute "campfire-libpurple[install]" do
  command "cp #{File.join(camp_dir, 'libcampfire.so')} /usr/lib/pidgin/libcampfire.so"
  creates "/usr/lib/pidgin/libcampfire.so"
end

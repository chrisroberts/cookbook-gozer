%w(
  build-essential openssl libreadline6 libreadline6-dev curl git-core 
  zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev 
  libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion 
  curl g++ openjdk-6-jre-headless
).each do |pkg_name|
  package pkg_name
end

ohai 'ruby' do
  action :nothing
end

execute 'rvm[install]' do
  command 'curl -L https://get.rvm.io | sudo bash -s stable'
  creates "/usr/local/rvm/bin/rvm"
  cwd "/home/#{node[:gozer][:username]}"
  user node[:gozer][:username]
  group 'nopass'
  notifies :reload, resources(:ohai => 'ruby'), :immediately
end

group 'rvm' do
  members Array(node[:gozer][:username])
end

execute 'rvm[ruby-1.9.3]' do
  command '/usr/local/rvm/bin/rvm install 1.9.3'
  user node[:gozer][:username]
  group 'rvm'
  not_if do
    system('/usr/local/rvm/bin/rvm list | grep ruby-1.9.3 > /dev/null')
  end
end

ruby_block 'set gem path' do
  block do
    node[:gozer][:rvm][:gem_paths] = %x{/usr/local/rvm/bin/rvm list}.split("\n").map(&:split).flatten.find_all{|s|s.start_with?('ruby-')}.map{|s|"/usr/local/rvm/rubies/#{s}/bin/gem"}
    Chef::Log.info "RVM based gem paths set: #{node[:gozer][:rvm][:gem_paths]}"
  end
  only_if do
    node[:gozer][:rvm][:gem_paths] != %x{/usr/local/rvm/bin/rvm list}.split("\n").map(&:split).flatten.find_all{|s|s.start_with?('ruby-')}.map{|s|"/usr/local/rvm/rubies/#{s}/bin/gem"}
  end
end

ruby_block 'install rvm gems' do
  block do
    node[:gozer][:rvm][:gem_paths].each do |gem_path|
      node[:gozer][:rvm][:gems].each do |gem_name|
        g_r = Chef::Resource::GemPackage.new(gem_name, run_context)
        g_r.gem_binary gem_path
        g_r.run_action(:install)
      end
    end
  end
end

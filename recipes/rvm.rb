node[:gozer][:rvm][:packages].each do |pkg_name|
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

node[:gozer][:rvm][:versions].each do |ruby_ver|

  execute "rvm[#{ruby_ver}]" do
    command "/usr/local/rvm/bin/rvm install #{ruby_ver}"
    user node[:gozer][:username]
    group 'rvm'
    not_if "/usr/local/rvm/bin/rvm list | grep #{ruby_ver} > /dev/null"
  end

end

ruby_block 'set gem path' do
  block do
    node.set[:gozer][:rvm][:gem_paths] = %x{/usr/local/rvm/bin/rvm list}.
      split("\n").map(&:split).
      flatten.find_all{|s| s.start_with?('ruby-')}.
      map{|s|"/usr/local/rvm/rubies/#{s}/bin/gem"}
    Chef::Log.info "RVM based gem paths set: #{node[:gozer][:rvm][:gem_paths]}"
  end
  only_if do
    node[:gozer][:rvm][:gem_paths] != %x{/usr/local/rvm/bin/rvm list}.
      split("\n").map(&:split).flatten.
      find_all{|s|s.start_with?('ruby-')}.
      map{|s|"/usr/local/rvm/rubies/#{s}/bin/gem"}
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

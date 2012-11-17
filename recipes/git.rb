include_recipe 'apt'

execute 'add git ppa repo' do
  command 'add-apt-repository -y ppa:git-core/ppa'
  not_if 'apt-cache policy | grep git-core'
  notifies :run, resources(:execute => 'apt-get update'), :immediately
end

package 'git'
package 'git-flow'

script 'git[install subtree]' do
  action :nothing
  user node[:gozer][:username]
  code <<-EOH
    [ ! -e '~/src/git-core' ] && mkdir -p ~/src/git-core
    cd ~/src/git-core && apt-get source git-core
    cd ~/src/git-core/git-*/contrib/subtree/
    [ -e '/usr/lib/git-core' ] && sed -i -e '/^libexecdir.*/ s|/libexec/|/lib/|' Makefile || echo '/usr/lib/git-core does not exist! Check that your libexec dir exists and reinstall git-subtree'
    sudo make prefix=/usr && sudo make prefix=/usr install && sudo make prefix=/usr install-doc
  EOH
  subscribes :run, resources(:package => 'git')
end

config_path = "/home/#{node[:gozer][:username]}/.gitconfig"

execute 'set git username' do
  command "git config --global user.name \"#{node[:gozer][:git][:name]}\""
  not_if do
    File.exists?(config_path) && File.read(config_path).include?(node[:gozer][:git][:name])
  end
end

execute 'set git email' do
  command "git config --global user.email \"#{node[:gozer][:git][:email]}\""
  not_if do
    File.exists?(config_path) && File.read(config_path).include?(node[:gozer][:git][:email])
  end
end

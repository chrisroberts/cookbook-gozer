package 'git'
package 'git-flow'

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

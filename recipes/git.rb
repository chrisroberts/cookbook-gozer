include_recipe 'gozer'

package 'git'

config_path = "/home/#{node[:gozer][:username]}/.gitconfig"

execute 'set git username' do
  command "git config -f #{config_path} user.name \"#{node[:gozer][:git][:name]}\""
  not_if do
    File.exists?(config_path) &&
      File.read(config_path).include?(node[:gozer][:git][:name])
  end
  user node[:gozer][:username]
  cwd "/home/#{node[:gozer][:username]}"
end

execute 'set git email' do
  command "git config -f #{config_path} user.email \"#{node[:gozer][:git][:email]}\""
  not_if do
    File.exists?(config_path) &&
      File.read(config_path).include?(node[:gozer][:git][:email])
  end
  user node[:gozer][:username]
  cwd "/home/#{node[:gozer][:username]}"
end

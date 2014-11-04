include_recipe 'gozer'
include_recipe 'gozer::powerline'

package 'tmux'

template File.join('/home', node[:gozer][:username], '.tmux.conf') do
  source 'tmux.conf.erb'
  mode 0644
  owner node[:gozer][:username]
end

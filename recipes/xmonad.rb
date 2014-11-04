include_recipe 'gozer'

package 'xmonad'
package 'taffybar'
package 'cabal-install'

execute 'update cabal package list' do
  command 'cabal update'
  user node[:gozer][:username]
  cwd File.join('/home', node[:gozer][:username])
  env 'HOME' => File.join('/home', node[:gozer][:username])
end

node[:gozer][:xmonad][:cabals].each do |pkg|

  execute "install #{pkg}" do
    command "cabal install #{pkg}"
    user node[:gozer][:username]
    cwd File.join('/home', node[:gozer][:username])
    env 'HOME' => File.join('/home', node[:gozer][:username])
  end

end

taffy_config = File.join('/home', node[:gozer][:username], '.config/taffybar/taffybar.hs')

directory File.dirname(taffy_config) do
  recursive true
  owner node[:gozer][:username]
end

template taffy_config do
  source 'taffybar.hs.erb'
  mode 0644
  owner node[:gozer][:username]
end

template File.join(File.dirname(taffy_config), 'taffybar.rc') do
  source 'taffybar.rc.erb'
  mode 0644
  owner node[:gozer][:username]
end

xmonad_config = File.join('/home', node[:gozer][:username], '.xmonad/xmonad.hs')

directory File.dirname(xmonad_config) do
  recursive true
  owner node[:gozer][:username]
end

template File.join('/home', node[:gozer][:username], '.config/xmonad.hs') do
  mode 0644
  source 'xmonad.hs.erb'
  owner node[:gozer][:username]
end

# check that dbus is loaded for pulse

ruby_block 'enable pulse audio dbus support' do
  block do
    content = File.readlines('/etc/pulse/default.pa').map(&:strip)
    content << 'load-module module-dbus-protocol'
    File.write('/etc/pulse/default.pa', 'w+') do |file|
      file.puts content.join("\n")
    end
  end
  not_if do
    !File.exists?('/etc/pulse/default.pa') ||
      File.readlines('/etc/pulse/default.pa').map(&:strip).include?('load-module module-dbus-protocol')
  end
end

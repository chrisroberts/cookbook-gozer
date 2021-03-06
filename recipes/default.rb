# Load our configuration in from data bag(s)
node.run_state[:gozer] = Mash.new(:config => Mash.new)

search(:gozer, "id:*").each do |item|
  if(item['cipher'])
    item = Mash.new(
      Chef::EncryptedDataBagItem.new(
        item, Chef::EncryptedDataBagItem.load_secret
      ).to_hash
    )
  else
    item = Mash.new(item.to_hash)
  end
  node.run_state[:gozer][:config] = Chef::Mixin::DeepMerge.merge(
    node.run_state[:gozer][:config], item
  )
end

include_recipe 'apt'

include_recipe 'gozer::home'
include_recipe 'gozer::write_files'

include_recipe 'gozer::system'
include_recipe 'gozer::sudoers'
include_recipe 'gozer::packages'
include_recipe 'gozer::git'
include_recipe 'gozer::rvm'
include_recipe 'gozer::emacs'
include_recipe 'gozer::google'
include_recipe 'gozer::virtualbox'
include_recipe 'gozer::go'
include_recipe 'gozer::virtualbox'
include_recipe 'gozer::direnv'
include_recipe 'gozer::bash-it'
include_recipe 'gozer::powerline'
include_recipe 'gozer::mount'
include_recipe 'gozer::tmux'
include_recipe 'gozer::wemux'

# Clean up the setup stuff
user 'ubuntu' do
  action :lock
end

if(node[:gozer][:enable_ui])
  node.set[:i3][:home] = "/home/#{node[:gozer][:username]}"
  node.set[:i3][:user] = node[:gozer][:username]
  node.set[:i3][:config][:execs] = ['~/bin/caps_to_esc.sh']

  include_recipe 'gozer::firefox'
  include_recipe 'gozer::xmonad'
  include_recipe 'i3'
end

# Only place data bag secret if we have any bags configured for it
unless(node[:gozer][:encrypted_bags].empty?)
  include_recipe 'gozer::encrypted_data_bag'
end

include_recipe 'gozer::home'  # always first

%w(
  system
  sudoers
  packages
  git
  vim
  irssi
  finch
  cone
  bash-it
  rvm
  firefox
  github
  google
  virtualbox
  go
  emacs
).each do |recipe_name|
  include_recipe "gozer::#{recipe_name}"
end

user 'ubuntu' do
  action :lock
end

node[:i3][:home] = "/home/#{node[:gozer][:username]}"
node[:i3][:user] = node[:gozer][:username]
node[:i3][:config][:execs] = ['~/bin/caps_to_esc.sh']

include_recipe 'i3'

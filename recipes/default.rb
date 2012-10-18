# Only place data bag secret if we have any bags configured for it
unless(node[:gozer][:encrypted_bags].empty?)
  include_recipe 'gozer::encrypted_data_bag'
end

%w(
  system
  sudoers
  home
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
  go
).each do |recipe_name|
  include_recipe "gozer::#{recipe_name}"
end

user 'ubuntu' do
  action :lock
end

node.set_unless[:i3][:home] = "/home/#{node[:gozer][:username]}"
node.set_unless[:i3][:user] = node[:gozer][:username]
include_recipe 'i3'

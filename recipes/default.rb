%w(
  sudoers
  home
  packages
  system
  vim
  irssi
  finch
  cone
  bash-it
  rvm
).each do |recipe_name|
  include_recipe "gozer::#{recipe_name}"
end

user 'ubuntu' do
  action :lock
end

node.set_unless[:i3][:home] = "/home/#{node[:gozer][:username]}"
node.set_unless[:i3][:user] = node[:gozer][:username]
include_recipe 'i3'

%w(
  sudoers
  home
  packages
  system
  xmonad
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

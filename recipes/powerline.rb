include_recipe 'gozer'

execute 'powerline clone' do
  command 'git clone http://github.com/erikw/tmux-powerline.git'
  cwd '/opt'
  creates '/opt/tmux-powerline/README.md'
end

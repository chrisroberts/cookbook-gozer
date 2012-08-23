default[:gozer][:packages] = %w(tmux moc)
default[:gozer][:hostname] = 'gozer'
default[:gozer][:username] = 'spox'
default[:gozer][:skype_package] = 'http://download.skype.com/linux/skype-ubuntu_4.0.0.8-1_amd64.deb'
default[:gozer][:projects][:git] = {}
default[:gozer][:vim][:bundles] = %w(
  git://github.com/altercation/vim-colors-solarized.git
  git://github.com/elixir-lang/vim-elixir.git
)

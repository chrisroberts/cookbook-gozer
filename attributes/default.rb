default[:gozer][:packages] = %w(tmux moc)
default[:gozer][:hostname] = 'gozer'
default[:gozer][:username] = 'spox'
default[:gozer][:skype_package] = 'http://download.skype.com/linux/skype-ubuntu_4.0.0.8-1_amd64.deb'
default[:gozer][:github][:accounts] = []
default[:gozer][:github][:exclude] = {}
default[:gozer][:github][:allow_forks] = {}
default[:gozer][:projects][:git] = {}
default[:gozer][:vim][:bundles] = %w(
  git://github.com/altercation/vim-colors-solarized.git
  git://github.com/elixir-lang/vim-elixir.git
)
default[:gozer][:backup][:uuid] = nil
default[:gozer][:firefox][:extension_dir] = '/usr/lib/firefox-addons/extensions'
default[:gozer][:firefox][:addons] = {
  :ghostery => 'https://addons.mozilla.org/firefox/downloads/latest/9609/addon-9609-latest.xpi?src=hp-dl-featured',
  :adblock => 'https://addons.mozilla.org/firefox/downloads/latest/1865/addon-1865-latest.xpi?src=ss',
  :flashblock => 'https://addons.mozilla.org/firefox/downloads/latest/433/addon-433-latest.xpi?src=search',
  :noscript => 'https://addons.mozilla.org/en-US/firefox/addon/noscript/?src=search'
}

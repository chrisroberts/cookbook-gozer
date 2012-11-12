default[:gozer][:packages] = %w(tmux moc wireshark chromium-browser)
default[:gozer][:kill_packages] = %w(thunderbird)
default[:gozer][:custom_packages] = '/opt/custom_packages'
default[:gozer][:hostname] = 'gozer'
default[:gozer][:username] = 'spox'
default[:gozer][:skype_package] = 'http://download.skype.com/linux/skype-ubuntu_4.0.0.8-1_amd64.deb'
default[:gozer][:git][:name] = 'John Doe'
default[:gozer][:git][:email] = 'john.doe@example.com'
default[:gozer][:github][:accounts] = []
default[:gozer][:github][:exclude] = {}
default[:gozer][:github][:allow_forks] = {}
default[:gozer][:projects][:git] = {}
default[:gozer][:rvm][:gems] = %w(chef vagrant veewee knife-ec2 bundler)
default[:gozer][:opscode][:user] = 'chrisroberts'

# Bag encryption (by default, we encrypte everything we are currently configuring)
default[:gozer][:data_bag_name] = 'gozer'
default[:gozer][:encrypted_bags] = %w(ssh_keys chef openvpn irssi account_info conerc skype purple google)

default[:gozer][:vim][:bundles] = %w(
  git://github.com/altercation/vim-colors-solarized.git
  git://github.com/elixir-lang/vim-elixir.git
)
default[:gozer][:emacs][:package_name] = 'emacs24-nox'
default[:gozer][:emacs][:marmalade_packages] = %w(
  starter-kit
  starter-kit-lisp
  starter-kit-bindings
  starter-kit-ruby
  rvm
  gist
)
default[:gozer][:backup][:uuid] = nil
default[:gozer][:firefox][:extension_dir] = '/usr/lib/firefox-addons/extensions'
default[:gozer][:firefox][:addons] = {
  :ghostery => 'https://addons.mozilla.org/firefox/downloads/latest/9609/addon-9609-latest.xpi?src=hp-dl-featured',
  :adblock => 'https://addons.mozilla.org/firefox/downloads/latest/1865/addon-1865-latest.xpi?src=ss',
  :flashblock => 'https://addons.mozilla.org/firefox/downloads/latest/433/addon-433-latest.xpi?src=search',
  :noscript => 'https://addons.mozilla.org/firefox/downloads/latest/722/addon-722-latest.xpi?src=dp-btn-primary'
}
default[:gozer][:github][:known_hosts] = [
  '|1|CACPIcyGzkYAImUrj0r0XLf79As=|rAVQh4J0mo/UyusXg32ENK2RCqM= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==',
  '|1|nJOphBvYrw4FNMk75shRidnVAlw=|BuG7amvSzq8fnAvYFGubFSzB024= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ=='
]

default[:gozer][:enable_ui] = false

default[:gozer][:console][:packages] = ['tmux', 'rxvt-unicode-256color', 'moc', 'openvpn', 'ssh', 'irssi']
default[:gozer][:ui][:packages] = [
  'wireshark', 'firefox', 'chromium-browser', 'chromium-codecs-ffmpeg-extra',
  'flashplugin-installer', 'xvnc4viewer', 'qingy'
]

default[:gozer][:kill_packages] = ['thunderbird']
default[:gozer][:custom_packages] = '/opt/custom_packages'
default[:gozer][:hostname] = 'gozer'
default[:gozer][:username] = 'spox'
default[:gozer][:groups] = [
  'adm', 'dialout', 'cdrom', 'plugdev', 'lpadmin',
  'admin', 'sambashare', 'nopass'
]

default[:gozer][:bash_it][:aliases] = [
  'bundler.aliases.bash', 'general.aliases.bash', 'git.aliases.bash',
  'todo.txt-cli.aliases.bash'
]
default[:gozer][:bash_it][:completion] = [
  'defaults.completion.bash', 'gem.completion.bash', 'git.completion.bash',
  'ssh.completion.bash', 'tmux.completion.bash', 'todo.completion.bash'
]
default[:gozer][:bash_it][:plugins] = [
  'base.plugin.bash', 'browser.plugin.bash', 'extract.plugin.bash',
  'ruby.plugin.bash', 'ssh.plugin.bash', 'todo.plugin.bash', 'z.plugin.bash',
  'battery.plugin.bash', 'dirs.plugin.bash', 'git.plugin.bash', 'rvm.plugin.bash',
  'tmux.plugin.bash', 'vagrant.plugin.bash'
]

default[:gozer][:mount][:path] = '/srv/store'
default[:gozer][:mount][:credentials] = '/etc/mount-creds'
default[:gozer][:mount][:host] = 'databucket'
default[:gozer][:mount][:share] = '/homes/spox'
default[:gozer][:mount][:link] = '/home/spox/Data'

default[:gozer][:rvm][:packages] = [
  'build-essential', 'openssl', 'libreadline6', 'libreadline6-dev', 'curl', 'git-core',
  'zlib1g', 'zlib1g-dev', 'libssl-dev', 'libyaml-dev', 'libsqlite3-dev', 'sqlite3', 'libxml2-dev',
  'libxslt-dev', 'autoconf', 'libc6-dev', 'ncurses-dev', 'automake', 'libtool', 'bison', 'subversion',
  'curl', 'g++', 'openjdk-6-jre-headless', 'pkg-config', 'libgdbm-dev', 'libffi-dev', 'gawk'
]
default[:gozer][:rvm][:versions] = [
  '1.9.3',
  '2.0.0',
  '2.1.0',
  '2.1.2'
]

default[:gozer][:git][:name] = 'Chris Roberts'
default[:gozer][:git][:email] = 'code@chrisroberts.org'
default[:gozer][:github][:accounts] = []
default[:gozer][:github][:exclude] = {}
default[:gozer][:github][:allow_forks] = {}
default[:gozer][:projects][:git] = {}
default[:gozer][:rvm][:gems] = ['bundler', 'hub', 'pry', 'octokit', 'librarian-chef']
default[:gozer][:opscode][:user] = 'chrisroberts'

# Bag encryption (by default, we encrypt everything we are currently configuring)
default[:gozer][:data_bag_name] = 'gozer'

default[:gozer][:emacs][:package_name] = 'emacs24-nox'
default[:gozer][:emacs][:melpa_packages] = [
  'starter-kit', 'starter-kit-bindings', 'starter-kit-ruby',
  'starter-kit-js', 'json-mode', 'flymake-json', 'flymake-ruby',
  'rvm', 'gist', 'haml-mode'
]

default[:gozer][:wemux][:config] = {
  :host_list => ['spox'],
  :allow_pair_mode => true,
  :allow_rouge_mode => true,
  :default_client_mode => 'pair',
  :allow_server_change => true,
  :default_server_name => 'gozer'
}

default[:gozer][:firefox][:extension_dir] = '/usr/lib/firefox-addons/extensions'
default[:gozer][:firefox][:addons] = {
  :ghostery => 'https://addons.mozilla.org/firefox/downloads/latest/9609/addon-9609-latest.xpi',
  :adblock => 'https://addons.mozilla.org/firefox/downloads/latest/1865/addon-1865-latest.xpi',
  :flashblock => 'https://addons.mozilla.org/firefox/downloads/latest/433/addon-433-latest.xpi',
  :noscript => 'https://addons.mozilla.org/firefox/downloads/latest/722/addon-722-latest.xpi'
}
default[:gozer][:github][:known_hosts] = [
  '|1|CACPIcyGzkYAImUrj0r0XLf79As=|rAVQh4J0mo/UyusXg32ENK2RCqM= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==',
  '|1|nJOphBvYrw4FNMk75shRidnVAlw=|BuG7amvSzq8fnAvYFGubFSzB024= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ=='
]

default[:gozer][:tmux]
default[:gozer][:xmonad][:cabals] = []

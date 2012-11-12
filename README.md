# Gozer

This cookbook builds a workstation. It is customized to build a workstation for
me. That means if you are just like me, then this is just the cookbook for you.

## What's it built on?

This cookbook was intended to used against a fresh install of xubuntu. But since
it's structured around ubuntu, really any flavor should work. Xubuntu just provides
a nice set of default apps that integrate well with everything else.

## What's it provide?

It provides all the things I need or want on my workstations. Most configuration
is data bag driven. Generally configuration files are built and the contents then
stuffed into a data bag. Things get moved into templates as I find custom configs
are required/wanted between different machines. Stuff you get:

### i3

The i3 window manager. This is installed from a standalone cookbook.

### Cone

Cone is a console email client. It's made by those courier folks. Configuration
of the .cone/conerc file is via data bag structured like:

```
# data_bags/gozer/conerc.json
{
  "id": "conerc",
  "content": "conerc_file_contents"
}
```

### Finch

Finch is a console version of pidgin. I use it for all my IM needs. This recipe
basically takes care of IM related bits, so it will install finch plus Skype
and a campfire plugin for finch. It uses a couple data bags for configuration.
The skype item for skype and the purple item for finch:

```
# data_bags/gozer/skype.json
{
  "id": "skype",
  "username": "skype.username",
  "content": "~/.Skype/skype.username/config.xml"
}

# data_bags/gozer/purple.json"
{
  "id": "purple",
  "files": {
    "accounts.xml": "contents_of_dot_purple_accounts.xml",
    "prefs.xml": "contents_of_dot_purple_prefs.xml"
  }
}
```

### Firefox

Installs firefox and adds the default extensions that I use. Extensions
are enabled globally for the firefox install. Related attributes:

* `node[:gozer][:firefox][:extension_dir] = '/usr/lib/firefox-addons/extensions'`
* `node[:gozer][:firefox][:addons] = {:ghostery => 'https://addon_url.xpi'}`

By default the following addons are installed:

* ghostery
* adblock
* flashblock
* noscript

### Git

Installs git and git-flow. Configures git user.name and email. Attributes for
git config:

* `node[:gozer][:git][:name] = 'your name'`
* `node[:gozer][:git][:email] = 'your.email@example.com'`

### Github

Automatically pull repos from accounts and organizations as directed. Throws
them in a Projects directory within the user's home. Related attributes:

* `node[:gozer][:github][:accounts] = %w(chrisroberts spox)`
* `node[:gozer][:github][:exclude][:chrisroberts] = %w(red_unicorn)`
* `node[:gozer][:github][:allow_forks][:chrisroberts] = true`

NOTE: Important note that github interactions are currently unauthenticated. That means
that only public repositories will be cloned.

### Google

Adds a helper script for gcalcli to easily display calendar and agenda in the console.
A data bag is used for configuration. It looks like this:

```
# data_bags/gozer/google.json
{
  "id": "google",
  "info": {
    "user": "username@gmail.com",
    "password": "acct_pass"
  }
}
```

A helper script that uses this info will be available in /usr/local/bin named
`my_gcal` and can be used:

* `my_gcal calendar` -> Displays calendar and refreshes every hour
* `my_gcal agenda` -> Displays agenda and refreshes every hour

### Go

Installs the weekly package builds of go.

### Home

Sets up all the junk required in the home directory like ssh keys and the like. Oh,
also creates the user.

### irssi

Installs and loads configuration for irssi. Uses data bag for configuration:

```
# data_bags/gozer/irssi.json
{
  "id": "irssi",
  "content": "content_of_dot_irssi_config"
}
```

### Packages

Easy addition and removal of packages:

* `node[:gozer][:packages] = %w(tmux moc) # packages to install`
* `node[:gozer][:kill_pacakges] = %w(thunderbird) # packages to remove`

### RVM

Installs a global instance of RVM. Installs any requested gems into any available
RVM versions on the system.

* `node[:rvm][:gems] = %w(chef knife-ec2) # gems to install to rubies`

### Sudoers

Sets up the sudoers so no password is required

### System

Does system related stuff. Sets hostname. Does apt-get upgrades if updates found.

### Home

Creates the user account defined. Provides some custom scripts in the user's bin
directory. Adds some files from data bags for .ssh and .chef:

```
# data_bags/gozer/chef.json
{
  "id": "chef",
  "files": {
    "my.pem": "contents",
    "other_file": "contents"
  }
}

# data_bags/gozer/ssh_keys
{
  "id": "ssh_keys",
  "keys": {
    "id_rsa": "contents",
    "id_rsa.pub": "contents"
  }
}
```

### VIM

Installs and configures vim. Adds some plugins.

* `node[:gozer][:vim][:bundles] = %w(git://github.com/altercation/vim-colors-solarized.git)`

### Emacs

Installs and configures emacs. Adds some plugins. Default installation package
is emacs24-nox which assumes ubuntu >= 12.10. Adds packages from marmalade.

* `node[:gozer][:emacs][:package_name] = 'emacs24-nox'`
* `default[:gozer][:emacs][:marmalade_packages] = %w(
  starter-kit
  starter-kit-lisp
  starter-kit-bindings
  starter-kit-ruby
  rvm
  gist
)`

### Virtualbox

Installs virtualbox and related packages

### VPNs

Installs VPN software plus configuration files

### Backup

A backup script is provided for rsyncing the user home directory to an external
device. The disk UUID is used for identification while mounting:

## Other attributes

* `node[:gozer][:data_bag_name] = 'gozer'`

This is the name used when finding data bag item configurations

* `node[:gozer][:encrypted_bags] = %w(ssh_keys chef irssi)

This is the list of data bag items that are encrypted. By default all data bag items
used by the recipes are here.

* `node[:gozer][:github][:known_hosts] = []`

The known hosts for dealing with github

### Backup

Provides backup script for syncing home directory to disk. Uses disk UUID for
identification when mounting

* `node[:gozer][:backup][:uuid] = 'disk-uuid'`

## Repo

* https://github.com/chrisroberts/cookbook-gozer

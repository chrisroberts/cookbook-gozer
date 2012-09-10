include_recipe 'gozer::git'

execute 'bash-it[install]' do
  command "git clone git://github.com/revans/bash-it.git /home/#{node[:gozer][:username]}/.bash_it"
  creates "/home/#{node[:gozer][:username]}/.bash_it"
  cwd "/home/#{node[:gozer][:username]}"
  user node[:gozer][:username]
  group node[:gozer][:username]
end

%w(aliases completion plugins).each do |key|
  directory "/home/#{node[:gozer][:username]}/.bash_it/#{key}/enabled" do
    action :create
  end
end

%w(
  bundler.aliases.bash general.aliases.bash git.aliases.bash 
  todo.txt-cli.aliases.bash vim.aliases.bash
).each do |als|
  link "/home/#{node[:gozer][:username]}/.bash_it/aliases/enabled/#{als}" do
    to "/home/#{node[:gozer][:username]}/.bash_it/aliases/available/#{als}"
    owner node[:gozer][:username]
    group node[:gozer][:username]
  end
end

%w(
  defaults.completion.bash gem.completion.bash git.completion.bash 
  ssh.completion.bash tmux.completion.bash todo.completion.bash
).each do |comp|
  link "/home/#{node[:gozer][:username]}/.bash_it/completion/enabled/#{comp}" do
    to "/home/#{node[:gozer][:username]}/.bash_it/completion/available/#{comp}"
    owner node[:gozer][:username]
    group node[:gozer][:username]
  end
end

%w(
  base.plugin.bash browser.plugin.bash extract.plugin.bash 
  ruby.plugin.bash ssh.plugin.bash todo.plugin.bash z.plugin.bash
  battery.plugin.bash dirs.plugin.bash git.plugin.bash rvm.plugin.bash 
  tmux.plugin.bash vagrant.plugin.bash
).each do |plug|
  link "/home/#{node[:gozer][:username]}/.bash_it/plugins/enabled/#{plug}" do
    to "/home/#{node[:gozer][:username]}/.bash_it/plugins/available/#{plug}"
    owner node[:gozer][:username]
    group node[:gozer][:username]
  end
end

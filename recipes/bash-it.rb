include_recipe 'gozer'
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

node[:gozer][:bash_it].fetch(:aliases, []).each do |als|
  link "/home/#{node[:gozer][:username]}/.bash_it/aliases/enabled/#{als}" do
    to "/home/#{node[:gozer][:username]}/.bash_it/aliases/available/#{als}"
    owner node[:gozer][:username]
    group node[:gozer][:username]
  end
end

node[:gozer][:bash_it].fetch(:completion, []).each do |comp|
  link "/home/#{node[:gozer][:username]}/.bash_it/completion/enabled/#{comp}" do
    to "/home/#{node[:gozer][:username]}/.bash_it/completion/available/#{comp}"
    owner node[:gozer][:username]
    group node[:gozer][:username]
  end
end

node[:gozer][:bash_it].fetch(:plugins, []).each do |plug|
  link "/home/#{node[:gozer][:username]}/.bash_it/plugins/enabled/#{plug}" do
    to "/home/#{node[:gozer][:username]}/.bash_it/plugins/available/#{plug}"
    owner node[:gozer][:username]
    group node[:gozer][:username]
  end
end

package 'cone'

conerc = gozer_bag('conerc')

if(conerc)
  directory "/home/#{node[:gozer][:username]}/.cone" do
    action :create
    owner node[:gozer][:username]
    group node[:gozer][:username]
  end

  file "/home/#{node[:gozer][:username]}/.cone/conerc" do
    content conerc['content']
    owner node[:gozer][:username]
    group node[:gozer][:username]
  end
end

include_recipe 'apt'

execute 'add go ppa repo' do
  command 'add-apt-repository -y ppa:gophers/go'
  not_if 'apt-cache policy | grep gophers'
  notifies :run, resources(:execute => 'apt-get update'), :immediately
end

package 'golang-weekly'


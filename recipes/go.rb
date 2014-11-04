include_recipe 'apt'

package 'golang' do
  action :install
  subscribes :upgrade, 'execute[apt-get update]'
end

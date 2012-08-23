package 'vim'

cookbook_file "/home/#{node[:gozer][:username]}/.vimrc" do
  source 'vimrc'
  mode 0644
  owner node[:gozer][:username]
  group node[:gozer][:username]
end

package 'git'

%w(.vim .vim/bundle .vim/autoload).each do |dir|
  directory "/home/#{node[:gozer][:username]}/#{dir}" do
    action :create
    mode 0755
    owner node[:gozer][:username]
    group node[:gozer][:username]
  end
end

remote_file "/home/#{node[:gozer][:username]}/.vim/autoload/pathogen.vim" do
  action :create_if_missing
  source 'https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim'
  mode 0644
  owner node[:gozer][:username]
  group node[:gozer][:username]
end

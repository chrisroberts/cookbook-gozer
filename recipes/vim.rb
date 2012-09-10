include_recipe 'gozer::git'
package 'vim'

cookbook_file "/home/#{node[:gozer][:username]}/.vimrc" do
  source 'vimrc'
  mode 0644
  owner node[:gozer][:username]
  group node[:gozer][:username]
end

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

node[:gozer][:vim][:bundles].each do |bundle_repo|
  execute "vim -> clone #{bundle_repo}" do
    command "git clone #{bundle_repo}"
    cwd "/home/#{node[:gozer][:username]}/.vim/bundle"
    user node[:gozer][:username]
    group node[:gozer][:username]
    not_if do
      File.directory?(
        File.join(
          "/home/#{node[:gozer][:username]}/.vim/bundle",
          File.basename(bundle_repo).sub('.git', '')
        )
      )
    end
  end
end

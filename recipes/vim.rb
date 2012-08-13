package 'vim'

cookbook_file "/home/#{node[:gozer][:username]}/.vimrc" do
  source 'vimrc'
  mode 0644
  owner node[:gozer][:username]
  group node[:gozer][:username]
end



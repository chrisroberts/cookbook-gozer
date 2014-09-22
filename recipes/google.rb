package 'gcalcli'

cookbook_file '/usr/local/bin/my_gcal' do
  source 'gcal_helper.rb'
  mode 0755
end

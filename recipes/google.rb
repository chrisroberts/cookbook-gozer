package 'gcalcli'
gem_package 'json'

acct_bag = gozer_bag('google')

file '/etc/google.json' do
  content JSON.pretty_generate(acct_bag['info'])
  mode 0644
end

cookbook_file '/usr/local/bin/my_gcal' do
  source 'gcal_helper.rb'
  mode 0755
end

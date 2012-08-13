file '/etc/hostname' do
  content node[:gozer][:hostname]
  mode 0644
end

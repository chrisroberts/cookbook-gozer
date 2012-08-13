cookbook_file '/etc/sudoers.d/nopass' do
  source 'nopass'
  mode 0440
end

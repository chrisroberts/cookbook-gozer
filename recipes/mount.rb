package 'cifs-utils'

mount_string = [
  "//#{File.join(node[:gozer][:mount][:host], node[:gozer][:mount][:share])}",
  node[:gozer][:mount][:path],
  'cifs', [
    "uid=#{node[:gozer][:username]}",
    "gid=#{node[:gozer][:username]}",
    "credentials=#{node[:gozer][:mount][:credentials]}",
    'iocharset=utf8',
    'sec=ntlm'
  ].join(','), '0', '0'
].join(' ')

directory node[:gozer][:mount][:path] do
  recursive true
end

file '/etc/fstab' do
  content lazy{
    contents = File.readlines('/etc/fstab').map(&:strip)
    contents << mount_string
    contents.push('').join("\n")
  }
  not_if do
    File.readlines('/etc/fstab').map(&:strip).include?(mount_string)
  end
end

execute 'mount data' do
  command "mount #{node[:gozer][:mount][:path]}"
  not_if "mount | grep '#{node[:gozer][:mount][:path]}'"
end

link node[:gozer][:mount][:link].to_s do
  to node[:gozer][:mount][:path]
  only_if{ node[:gozer][:mount][:link] }
end

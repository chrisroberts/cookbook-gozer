package 'cifs-utils'

mount_string = [
  "//#{File.join(node[:gozer][:mount][:host], node[:gozer][:mount][:share])}",
  node[:gozer][:mount][:path],
  'cifs', [
    "credentials=#{node[:gozer][:mount][credentials]}",
    'iocharset=utf8',
    'sec=ntlm'
  ], '0', '0'
]

directory '/mnt/spox_home' do
  recurisve true
  owner node[:gozer][:username]
end

file '/etc/fstab' do
  contents lazy{
    content = File.readlines('/etc/fstab')
    content << mount_string
    content.push('').join("\n")
  end
  not_if do
    File.readlines('/etc/fstab').include?(mount_string)
  end
end

link node[:gozer][:mount][:link].to_s do
  to node[:gozer][:mount][:path]
  only_if{ node[:gozer][:mount][:link] }
end

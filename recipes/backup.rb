if(node[:gozer][:backup][:uuid])
  package 'rsync'

  template '/usr/local/bin/gozer_backup' do
    source 'backup.sh.erb'
    mode 0755
    variables(
      :uuid => node[:gozer][:backup][:uuid],
      :home_path => "/home/#{node[:gozer][:username]}"
    )
  end

  cron 'backup' do
    hour '01'
    shell '/bin/bash'
    command '/bin/bash /usr/local/bin/gozer_backup'
  end
else
  Chef::Log.warn "No backup UUID found. Backups are not currently enabled!"
end

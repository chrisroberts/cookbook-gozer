%w(
  build-essential openssl libreadline6 libreadline6-dev curl git-core 
  zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev 
  libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion 
  curl g++ openjdk-6-jre-headless
).each do |pkg_name|
  package pkg_name
end

execute 'rvm[install]' do
  command 'curl -L https://get.rvm.io | sudo bash -s stable'
  creates "/usr/local/rvm"
  cwd "/home/#{node[:gozer][:username]}"
  user node[:gozer][:username]
  group 'nopass'
end

group 'rvm' do
  members Array(node[:gozer][:username])
end


execute 'rvm[ruby-1.9.3]' do
  command '/usr/local/rvm/bin/rvm install 1.9.3'
  user node[:gozer][:username]
  group 'rvm'
  not_if do
    system('/usr/local/rvm/bin/rvm list | grep ruby-1.9.3 > /dev/null')
  end
end

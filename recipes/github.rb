require 'open-uri'

include_recipe 'gozer::git'

file "/home/#{node[:gozer][:username]}/.ssh/known_hosts" do
  action :create_if_missing
  mode 0600
  owner node[:gozer][:username]
  group node[:gozer][:username]
  content node[:gozer][:github][:known_hosts].join("\n")
end

ruby_block 'Make github a known host' do
  block do
    file = Chef::Util::FileEdit.new("/home/#{node[:gozer][:username]}/.ssh/known_hosts")
    node[:gozer][:github][:known_hosts].each do |line|
      file.insert_line_if_no_match(Regexp.escape(line), line)
    end
  end
end

directory "/home/#{node[:gozer][:username]}/Projects" do
  action :create
  owner node[:gozer][:username]
  group node[:gozer][:username]
end

node[:gozer][:projects][:git].each do |k,v|
  File.dirname(v).split('/').inject("/home/#{node[:gozer][:username]}/Projects") do |memo, obj|
    memo << "/#{obj}"
    directory memo do
      action :create
      mode 0755
      owner node[:gozer][:username]
      group node[:gozer][:username]
    end
    memo
  end
  name = File.join(v, File.basename(k)).sub('.git', '')
  execute "clone #{k}" do
    command "git clone #{k} #{File.join("/home/#{node[:gozer][:username]}/Projects", name)}"
    cwd "/home/#{node[:gozer][:username]}/Projects"
    user node[:gozer][:username]
    group node[:gozer][:username]
    not_if do
      p_dir = v || File.basename(k).sub('.git', '')
      File.directory?("/home/#{node[:gozer][:username]}/Projects/#{p_dir}")
    end
  end
end

node[:gozer][:github][:accounts].each do |acct|
  base_path = File.join("/home/#{node[:gozer][:username]}/Projects", acct)
  page = 1

  directory base_path do
    owner node[:gozer][:username]
    group node[:gozer][:group]
  end

  # NOTE: SSL cert fails for github using embedded (omnibus)  
  begin
    until((repos = JSON.parse(open("https://api.github.com/users/#{acct}/repos?page=#{page}", :ssl_verify_mode => 0).read)).empty?)
      repos.each do |repo_info|
        repo_name = repo_info['full_name'].split('/').last
        next if node[:gozer][:github][:exclude][acct] && node[:gozer][:github][:exclude][acct].include?(repo_name)
        next if !node[:gozer][:github][:allow_forks][acct] && repo_info['fork']
        execute "clone #{repo_info['full_name']}" do
          command "git clone #{repo_info['ssh_url']} #{File.join(base_path, repo_name)} > /dev/null"
          user node[:gozer][:username]
          group node[:gozer][:username]
          creates File.join(base_path, repo_name, '.git')
        end
      end
      page += 1
    end
  rescue OpenURI::HTTPError
    Chef::Log.warn 'Looks like github is being finicky. Will try again on next run!'
  rescue => e
    Chef::Log.warn "Error encountered connecting to github: #{e}"
  end
end

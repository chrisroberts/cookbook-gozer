require 'open-uri'

package 'git'

directory "/home/#{node[:gozer][:username]}/Projects" do
  action :create
  owner node[:gozer][:username]
  group node[:gozer][:username]
end

node[:gozer][:github].each do |k,v|
  node[:gozer][:projects][:git].each do |k,v|
    if(v && File.dirname(v) != '.')
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
    end
    execute "clone #{k}" do
      command "git clone #{k} #{File.join("/home/#{node[:gozer][:username]}/Projects", v) if v}"
      cwd "/home/#{node[:gozer][:username]}/Projects"
      user node[:gozer][:username]
      group node[:gozer][:username]
      not_if do
        p_dir = v || File.basename(k).sub('.git', '')
        File.directory?("/home/#{node[:gozer][:username]}/Projects/#{p_dir}")
      end
    end
  end
end

node[:gozer][:github][:accounts].each do |acct|
  base_path = File.join("/home/#{node[:gozer][:username]}/Projects", acct)

  directory base_path do
    owner node[:gozer][:username]
    group node[:gozer][:group]
  end

  
  JSON.parse(open("https://api.github.com/users/#{acct}").read).each do |repo_info|
    repo_name = repo_info['full_name'].split('/').last
    next if node[:gozer][:github][:exclude][acct] && node[:gozer][:github][:exclude][acct].include?(repo_name)
    next if !node[:gozer][:github][:allow_forks][acct] && repo_info['fork']
    execute "clone #{repo_info['full_name']}" do
      command "git clone #{repo_info['ssh_url']} #{File.join(base_path, repo_name)}"
      user node[:gozer][:username]
      group node[:gozer][:username]
      creates File.join(base_path, repo_name, '.git')
    end
  end
end
# Lets write files!

node.run_state[:gozer][:config].fetch(:files, {}).each do |path, stuff|

  set_owner = path.include?("/home/#{node[:gozer][:username]}")

  directory File.dirname(path) do
    recursive true
    if(set_owner)
      owner node[:gozer][:username]
    end
  end

  file path do
    content stuff.is_a?(String) ? stuff : Chef::JSONCompat.to_json(stuff)
    if(set_owner)
      owner node[:gozer][:username]
    end
    mode 0600
  end

end

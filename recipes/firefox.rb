node[:gozer][:firefox][:addons].each do |name, location|
  remote_file File.join(node[:gozer][:firefox][:extension_dir], "#{name}.xpi") do
    source location
    mode 0644
    action :create_if_missing
  end

  ruby_block "firefox addon #{name} notifier" do
    block do
      Chef::Log.info "Firefox addon *#{name}* installed!"
    end
    action :nothing
    subscribes
  end
end

node[:gozer][:packages].each do |pkg_name|
  package pkg_name
end

node[:gozer][:kill_packages].each do |pkg_name|
  package pkg_name do
    action :remove
  end
end

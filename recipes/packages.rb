
node[:gozer][:console][:packages].each do |pkg_name|
  package pkg_name
end

node[:gozer][:ui][:packages].each do |pkg_name|
  package pkg_name do
    only_if{ node[:gozer][:ui_enabled] }
  end
end

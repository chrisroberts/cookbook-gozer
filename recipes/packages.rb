
node[:gozer][:console][:packages].each do |pkg_name|
  package pkg_name
end

node[:gozer][:ui][:packages].each do |pkg_name|
  package pkg_name do
    only_if{ node[:gozer][:enable_ui] }
  end
end

include_recipe 'rvm'

%w(virtualbox virtualbox-guest-additions-iso).each do |pkg|
  package pkg
end



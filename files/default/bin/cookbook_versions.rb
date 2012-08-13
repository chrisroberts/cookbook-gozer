#!/usr/bin/env ruby

path = Dir.pwd
unless(File.basename(path) == 'cookbooks')
  if(Dir.new(path).include?('cookbooks'))
    path = File.join(path, 'cookbooks')
  else
    raise "I'm not seeing any cookbooks around"
  end
end

items = []
Dir.glob(File.join(path, '*')).map.sort.each do |path| 
  next if !File.directory?(path) || !File.exists?(File.join(path, 'metadata.rb'))
  name = File.basename(path)
  version = File.readlines(File.join(path, 'metadata.rb')).find{|line|
    line[0,7] == 'version'
  }.strip.split(' ').last.strip.sub('"', '"= ')
  unless(version.to_s.empty?)
    items << '"' + name + '" => ' + version
  end
end
puts "{\n#{items.join(",\n")}\n}"

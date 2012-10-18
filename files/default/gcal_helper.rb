#!/usr/bin/env ruby

require 'json'
require 'shellwords'

config_file = '/etc/google.json'

unless(File.exists?(config_file))
  $stderr.puts "ERROR: Configuration file does not exist (#{config_file})"
  exit 1
end

config = JSON.parse(File.read(config_file))
config['calendar'] ||= {}
config['agenda'] ||= {}
command = ARGV.first

unless(command)
  $stderr.puts "ERROR: Please supply command 'agenda' or 'calendar'"
  exit 1
end

case command
when 'calendar'
  cal_cmd = "watch -n #{config['calendar']['interval'] || 3600} --color --no-title " <<
    "'gcalcli --user #{Shellwords.escape(config['user'])} " <<
    "--pw #{Shellwords.escape(config['password'])} --https "<<
    "--details calw #{config['calendar']['show_weeks'] || 1}'"
  system(cal_cmd)
when 'agenda'
  ag_cmd = "watch -n #{config['agenda']['interval'] || 3600} --color --no-title " <<
    "'gcalcli --user #{Shellwords.escape(config['user'])} " <<
    "--pw #{Shellwords.escape(config['password'])} --https "<<
    "--details agenda `date +%m/%d/%Y` `date --date=\"next month\" +%m/%d/%Y`'"
  system(ag_cmd)
else
  $stderr.puts "ERROR: Please supply command 'agenda' or 'calendar'"
  exit 1
end

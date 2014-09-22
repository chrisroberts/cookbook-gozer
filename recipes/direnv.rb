include_recipe 'gozer'

execute 'direnv clone' do
  command 'git clone http://github.com/zimbatm/direnv'
  cwd '/opt'
end

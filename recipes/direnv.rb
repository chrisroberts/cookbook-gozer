include_recipe 'gozer'

execute 'direnv clone' do
  command 'git clone http://github.com/zimbatm/direnv'
  cwd '/opt'
  creates '/opt/direnv/README.md'
end

execute 'compile direnv' do
  command 'make install'
  cwd '/opt/direnv'
  creates '/opt/direnv/direnv'
end

include_recipe 'gozer'

execute 'wemux update' do
  command 'git pull'
  cwd '/opt/wemux'
  only_if{ File.exists?('/opt/wemux/wemux') }
end

execute 'wemux clone' do
  command 'git clone https://github.com/zolrath/wemux'
  cwd '/opt'
  creates '/opt/wemux/wemux'
end

link '/usr/local/bin/wemux' do
  to '/opt/wemux/wemux'
end

directory '/usr/local/etc' do
  recursive true
end

file '/usr/local/etc/wemux.conf' do
  content lazy{
    node[:gozer][:wemux][:config].map do |k,v|
      if(v.is_a?(Array))
        "#{k}=(#{v.join(' ')})"
      else
        "#{k}=\"#{v}\""
      end
    end.join("\n")
  }
  mode 0644
end

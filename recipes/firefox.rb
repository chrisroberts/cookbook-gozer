require 'rexml/document'

package 'unzip'

directory node[:gozer][:custom_packages] do
  action :create
end

node[:gozer][:firefox][:addons].each do |name, location|
  xpi_path = File.join(node[:gozer][:custom_packages], "#{name}.xpi")
  remote_file xpi_path do
    source location
    mode 0644
    action :create_if_missing
  end

  ruby_block "firefox addon #{name} notifier" do
    block do
      o_dir = Dir.pwd
      tmp_dir = Dir.mktmpdir
      begin
        hold_dir = File.join(tmp_dir, 'holder')
        Dir.mkdir(hold_dir)
        FileUtils.copy(xpi_path, File.join(tmp_dir, "#{name}.xpi"))
        Dir.chdir(tmp_dir)
        raise 'Failed to unzip' unless system("unzip #{name}.xpi -d #{hold_dir} 2>1 > /dev/null")
        doc = REXML::Document.new(File.new(File.join(hold_dir, 'install.rdf')))
        id = doc.elements.collect('RDF/Description/em:id'){|i|i.text}.first
        if(id)
          ext_path = File.join(node[:gozer][:firefox][:extension_dir], id)
          Dir.mkdir(ext_path)
          raise 'Failed to unzip' unless system("unzip #{name}.xpi -d #{ext_path} 2>1 > /dev/null")
        else
          raise "Failed to determine extension ID for installation: #{name}"
        end
      ensure
        Dir.chdir(o_dir)
        FileUtils.remove_entry_secure(tmp_dir)
      end
      Chef::Log.info "Firefox addon *#{name}* installed!"
    end
    action :nothing
    subscribes :create, resources(:remote_file => xpi_path), :immediately
  end
end

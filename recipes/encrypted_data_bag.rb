# This is pretty much here for the initial bootstrap. Otherwise you
# are left to your own devices to get the secret in place
r_b = ruby_block 'store encrypted data bag secret' do
  block do
    %w(/etc/chef/validation.pem /tmp/encrypted_data_bag_secret).each do |path|
      if(File.exists?(path))
        FileUtils.cp(path, '/etc/chef/encrypted_data_bag_secret')
        Chef::Log.info "Encrypted data bag secret found at: #{path}"
      end
    end
  end
  action :nothing
  not_if do
    File.exists?('/etc/chef/encrypted_data_bag_secret')
  end
end

r_b.run_action(:create)

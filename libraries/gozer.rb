module Gozer
  class << self

    def bag_secret(secret)
      secret = '/etc/chef/encrypted_data_bag_secret' if secret == true
      if(File.exists?(secret))
        Chef::EncryptedDataBagItem.load_secret(secret)
      else
        secret
      end
    end
    
    def bag(bag_name, item_name, args={})
      begin
        if(args[:secret])
          s = args[:secret]
          Chef::EncryptedDataBagItem.load(bag_name, item_name, bag_secret(s)).to_hash
        else
          Chef::DataBagItem.load(bag_name, item_name).to_hash
        end
      rescue => e
        Chef::Log.info "Failed to retreive item: #{item_name} from data bag: #{bag_name}"
        raise e
      end
    end
  end

  def gozer_bag(item)
    Gozer.bag(
      node[:gozer][:data_bag_name], item, 
      :secret => node[:gozer][:encrypted_bags].include?(item.to_s)
    )
  end
end

Chef::Recipe.send(:include, Gozer)

module Gozer
  class << self

    def bag_secret(secret)
      if(File.exists?(secret))
        Chef::EncryptedDataBatItem.load_secret(secret)
      else
        secret
      end
    end
    
    def bag(bag_name, item_name, secret)
      begin
        if(secret)
          Chef::EncryptedDataBagItem.load(bag_name, bag_item, bag_secret(secret)).to_hash
        else
          Chef::DataBagItem.load(bag_name, item_name).to_hash
        end
      rescue => e
        Chef::Log.info "Failed to retreive item: #{bag_item} from data bag: #{bag_name}"
        Chef::Log.debug "#{e.class}: #{e}\n#{e.backtrace.join("\n")}"
      end
    end
  end
end

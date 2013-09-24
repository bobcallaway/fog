module Fog
  module Compute
    class SoftLayer
      class Real
        def update_virtual_server_metadata(id, metadata)
          request({
            :method => "POST",
            :path => "SoftLayer_Virtual_Guest/#{id}/setUserMetadata",
            :body => metadata
          },
          true
          )
        end
      end
    end
  end
end

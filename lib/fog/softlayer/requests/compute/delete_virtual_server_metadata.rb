module Fog
  module Compute
    class SoftLayer
      class Real
        def delete_virtual_server_metadata(id, key)
          # fetch list of metadata, strip out key if it exists, and reset it
          md = service.get_virtual_server_metadata(id)
          request(
            :method => "PUT",
            :path => "SoftLayer_Virtual_Guest/#{id}/getUserMetadata",
            :expects => [200]
          )
        end
      end
    end
  end
end

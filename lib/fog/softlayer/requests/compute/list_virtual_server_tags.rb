module Fog
  module Compute
    class SoftLayer
      class Real
        def list_virtual_server_tags(id)
          request(
            :method => "GET",
            :expects => 200,
            :path => "SoftLayer_Virtual_Guest/#{id}/getTagReferences"
          )
        end
      end
    end
  end
end

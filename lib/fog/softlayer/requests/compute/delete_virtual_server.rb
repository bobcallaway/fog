module Fog
  module Compute
    class SoftLayer
      class Real
        def delete_virtual_server(id)
          request( {
            :method => "DELETE",
            :path => "SoftLayer_Virtual_Guest/#{id}",
            :expects => [200]
            },
            true
          )
        end
      end
    end
  end
end

module Fog
  module Compute
    class SoftLayer
      class Real
        def start_virtual_server(id)
          request( {
            :method => "GET",
            :path => "SoftLayer_Virtual_Guest/#{id}/powerOn",
            :expects => 200
          },
          true
          )
        end
      end
    end
  end
end

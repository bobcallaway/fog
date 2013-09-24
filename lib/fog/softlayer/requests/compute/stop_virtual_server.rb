module Fog
  module Compute
    class SoftLayer
      class Real
        def stop_virtual_server(id)
          request( {
            :method => "GET",
            :path => "SoftLayer_Virtual_Guest/#{id}/powerOff",
            :expects => 200
          },
          true
          )
        end
      end
    end
  end
end

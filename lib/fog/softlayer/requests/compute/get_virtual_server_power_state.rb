module Fog
  module Compute
    class SoftLayer

      class Real
        def get_virtual_server_power_state(id)
          request(
            :method => "GET",
            :path => "SoftLayer_Virtual_Guest/#{id}/getPowerState",
            :expects => [200]
          )
        end
      end
    end
  end
end

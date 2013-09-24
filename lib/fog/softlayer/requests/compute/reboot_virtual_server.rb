module Fog
  module Compute
    class SoftLayer
      class Real
        def reboot_virtual_server(id)
          request({
            :method => "GET",
            :expects => 200,
            :path => "SoftLayer_Virtual_Guest/#{id}/rebootDefault"
          },
          true
          )
        end
      end
    end
  end
end

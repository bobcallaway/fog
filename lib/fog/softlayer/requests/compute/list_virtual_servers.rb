module Fog
  module Compute
    class SoftLayer

      class Mock
        def list_virtual_servers(options={})
          res = Excon::Response.new
          res.status = 200
          res.body = self.data[:virtual_servers].values
          res
        end
      end

      class Real
        def list_virtual_servers(options={})
          request(
            :method => "GET",
            :query => options,
            :path => "SoftLayer_Account/getVirtualGuests",
            :expects => 200
          )
        end
      end
    end
  end
end

module Fog
  module Compute
    class SoftLayer

      class Mock
        def get_virtual_server(id)
          if machine = self.data[:virtual_servers][id]
            res = Excon::Response.new
            res.status = 200
            res.body = machine
            res
          else
            raise Excon::Errors::NotFound, "Not Found"
          end
        end
      end

      class Real
        def get_virtual_server(id)
          request(
            :method => "GET",
            :path => "SoftLayer_Virtual_Guest/#{id}",
            :expects => [200, 410]
          )
        end
      end
    end
  end
end

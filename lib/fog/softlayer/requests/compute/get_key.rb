module Fog
  module Compute
    class SoftLayer
      class Mock

        def get_key(id)
          if key = self.data[:keys][id]
            response = Excon::Response.new
            response.status = 200
            response.body = key
            response
          else
            raise Excon::Errors::NotFound
          end
        end
      end

      class Real
        def get_key(id)
          request(
            :method => "GET",
            :path => "SoftLayer_Security_Ssh_Key/#{id}",
            :expects => 200
          )
        end
      end
    end
  end
end

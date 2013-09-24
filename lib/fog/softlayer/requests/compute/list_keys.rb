module Fog
  module Compute
    class SoftLayer
      class Mock
        def list_keys
          response = Excon::Response.new
          response.status = 200
          response.body = self.data[:keys].values
          response
        end
      end

      class Real
        def list_keys
          request(
            :expects => 200,
            :method => :'GET',
            :path => 'SoftLayer_Account/getSshKeys'
          )
        end
      end # Real

    end
  end
end

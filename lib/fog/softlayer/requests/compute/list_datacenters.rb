module Fog
  module Compute
    class SoftLayer

      class Real
        def list_datacenters
          request(
            :expects => 200,
            :method => :'GET',
            :path => 'SoftLayer_Location/getDatacenters'
          )
        end
      end # Real

    end
  end
end

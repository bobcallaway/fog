module Fog
  module Compute
    class SoftLayer
      class Real
        def list_tags()
          request(
            :path => "SoftLayer_Account/getTags",
            :method => "GET",
            :expects => 200
          )
        end
      end

      class Mock

      end
    end
  end
end

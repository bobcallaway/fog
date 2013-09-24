module Fog
  module Compute
    class SoftLayer
      class Real
        def delete_all_virtual_server_metadata(id)
          request(
            :method => "PUT",
            :path => "SoftLayer_Virtual_Guest/#{id}/setUserMetadata",
            :body => { :metadata => "" },
            :expects => 200
          },
          true
          )
        end
      end
    end
  end
end

module Fog
  module Compute
    class SoftLayer
      class Real
        def delete_all_virtual_server_tags(id)
          request({
            :method => "PUT",
            :body => { :tags => "" },
            :path => "SoftLayer_Virtual_Guest/#{id}/setTags",
            :expects => 200
          },
          true
          )
        end
      end
    end
  end
end

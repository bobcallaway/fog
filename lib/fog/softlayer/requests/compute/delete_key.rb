module Fog
  module Compute
    class SoftLayer

      class Mock
        def delete_key(id)
          if self.data[:keys].delete(id)
            response = Excon::Response.new
            response.status = 200
            response
          else
            raise Excon::Errors::NotFound, "Not Found"
          end
        end
      end

      class Real
        def delete_key(id)
          request( {
            :method => "DELETE",
            :path => "SoftLayer_Security_Ssh_Key/#{id}",
            :expects => 200 }, 
            true # the API returns the string 'true', not [true] so JSON parsing fails.
            )
        end
      end # Real

    end
  end
end

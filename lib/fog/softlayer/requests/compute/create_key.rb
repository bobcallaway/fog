module Fog
  module Compute
    class SoftLayer
      class Mock
        def create_key(params)
          label = params[:label]
          key = params[:key]
          notes = params[:notes]

          record = {
            "id" => 3,
            "key" => key,
            "label" => label,
            "notes" => notes,
            "createDate" => Time.now.utc,
            "modifiedDate" => nil
          }

          self.data[:keys][id] = record

          response = Excon::Response.new
          response.status = 201
          response.body = record
          response
        end
      end # Mock

      class Real

        def create_key(params={})
          raise ArgumentError, "error creating key: [label] is required" unless params[:label]
          raise ArgumentError, "error creating key: [key] is required" unless params[:key]

          request(
            :method => "POST",
            :path => "SoftLayer_Security_Ssh_Key",
            :body => { "parameters" => [ "label" => params[:label], "key" => params[:key], "notes" => params[:notes] ]},
            :expects => 201
          )
        end

      end
    end
  end
end

module Fog
  module Compute
    class SoftLayer
      class Real
        def get_virtual_server_metadata(id, options = {})
          query = {}
          if options[:credentials]
            if options[:credentials].is_a?(Boolean)
              query[:credentials] = options[:credentials]
            else
              raise ArgumentError, "options[:credentials] must be a Boolean or nil"
            end
          end

          request(
            :path => "/my/machines/#{machine_id}/metadata",
            :query => query
          )
        end
      end
    end
  end
end

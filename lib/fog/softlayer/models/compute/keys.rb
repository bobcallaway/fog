require 'fog/softlayer/models/compute/key'

module Fog
  module Compute
    class SoftLayer
      class Keys < Fog::Collection

        model Fog::Compute::SoftLayer::Key

        def all
          data = service.list_keys.body
          load(data)
        end

        def get(id)
          data = service.get_key(id).body
          if data
            new(data)
          else
            nil
          end
        end

        def create(params = {})
          raise ArgumentError, "option [label] required" unless params.key?(:label)
          raise ArgumentError, "option [key] required" unless params.key?(:key)

          service.create_key(params)
        end

      end
    end
  end
end

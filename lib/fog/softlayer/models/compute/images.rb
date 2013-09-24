require 'fog/core/collection'
require 'fog/softlayer/models/compute/image'

module Fog
  module Compute
    class SoftLayer
      class Images < Fog::Collection

        model Fog::Compute::SoftLayer::Image

        def all
          load(service.list_datasets().body)
        end

        def get(id)
          data = service.get_dataset(id).body
          new(data)
        end

      end # Images
    end # SoftLayer
  end # Compute
end # Fog

require 'fog/core/collection'
require 'fog/softlayer/models/compute/virtual_server'

module Fog
  module Compute

    class SoftLayer
      class VirtualServers < Fog::Collection
        model Fog::Compute::SoftLayer::VirtualServer

        def all
          load(service.list_virtual_servers().body)
        end

        def create(params = {})
          data = service.create_virtual_server(params).body
          server = new(data)
          server
        end

        def bootstrap(new_attributes = {})
          server = create(new_attributes)
          server.wait_for { ready? }
          server
        end

        def get(id)
          data = service.get_virtual_server(id).body
          server = new(data)
          server
        end

      end
    end # SoftLayer

  end # Compute
end # Fog

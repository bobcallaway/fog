require 'fog/compute/models/server'
module Fog
  module Compute
    class SoftLayer
      class VirtualServer < Fog::Compute::Server
        identity :id

        attribute :accountId
        attribute :createDate, :type => :time
        attribute :dedicatedAccountHostOnlyFlag
        attribute :domain
        attribute :fullyQualifiedDomainName
        attribute :globalIdentifier
        attribute :hostname
        attribute :lastPowerStateId
        attribute :lastVerifiedDate, :type => :time
        attribute :maxCpu
        attribute :maxCpuUnits
        attribute :maxMemory
        attribute :metricPollDate, :type => :time
        attribute :modifyDate, :type => :time
        attribute :primaryBackendIpAddress
        attribute :primaryIpAddress
        attribute :startCpus
        attribute :statusId
        attribute :uuid

        def ready?
          requires :id
          service.get_virtual_server_power_state(id).body["keyName"] == 'RUNNING'
        end

        def stopped?
          requires :id
          service.get_virtual_server_power_state(id).body["keyName"] == 'HALTED'
        end

        def destroy
          requires :id
          service.delete_virtual_server(id)
          true
        end

        def start
          requires :id
          service.start_virtual_server(id)
          self.wait_for { ready? }
          true
        end

        def stop
          requires :id
          service.stop_virtual_server(id)
          self.wait_for { stopped? }
          true
        end

        def reboot
          requires :id
          service.reboot_virtual_server(id)
          true
        end

        def snapshots
          requires :id
          service.snapshots.all(id)
        end

        def update_metadata(data = {})
          requires :id
          service.update_virtual_server_metadata(self.id, data)
          true
        end

        def delete_metadata(keyname)
          raise ArgumentError, "Must provide a key name to delete" if keyname.nil? || keyname.empty?
          requires :id

          service.delete_virtual_server_metadata(self.id, keyname)
          true
        end

        def delete_all_metadata
          requires :id
          service.delete_all_virtual_server_metadata(self.id)
          true
        end

        def list_tags
          requires :id
          service.list_virtual_server_tags(id).body
        end

        def add_tags(tags_hash = {})
          requires :id
          service.add_virtual_server_tags(self.id, tags_hash).body
        end

        def delete_tag(tagname)
          requires :id

          raise ArgumentError, "Must provide a tag name to delete" if tagname.nil? || tagname.empty?
          service.delete_virtual_server_tag(self.id, tagname)
          true
        end

        def delete_all_tags
          requires :id

          service.delete_all_virtual_server_tags(self.id)
          true
        end
      end
    end
  end
end

module Fog
  module Compute
    class SoftLayer
      class Key < Fog::Model
        identity :id

        attribute :id
        attribute :label
        attribute :notes

        attribute :key
        attribute :fingerprint

        attribute :createDate, :type => :time
        attribute :modifyDate, :type => :time

        def destroy
          requires :id
          service.delete_key(id)
        end
      end
    end
  end
end

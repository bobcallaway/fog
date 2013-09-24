module Fog
  module Compute
    class SoftLayer
      class Image < Fog::Model

        identity :id

        attribute :name
        attribute :accountId
        attribute :createDate, :type => :time
        attribute :globalIdentifier
        attribute :parentId
        attribute :transactionId
        attribute :userRecordId

      end
    end
  end
end

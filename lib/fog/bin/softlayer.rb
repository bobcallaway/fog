class SoftLayer < Fog::Bin
  class << self

    def class_for(key)
      case key
      when :compute
        Fog::Compute::SoftLayer
      else
        # @todo Replace most instances of ArgumentError with NotImplementedError
        # @todo For a list of widely supported Exceptions, see:
        # => http://www.zenspider.com/Languages/Ruby/QuickRef.html#35
        raise ArgumentError, "Unsupported #{self} service: #{key}"
      end
    end

    def [](service)
      @@connections ||= Hash.new do |hash, key|
        hash[key] = case key
        when :compute
          Fog::Logger.warning("SoftLayer[:compute] is not recommended, use Compute[:SoftLayer] for portability")
          Fog::Compute.new(:provider => 'SoftLayer')
        else
          raise ArgumentError, "Unrecognized service: #{key.inspect}"
        end
      end
      @@connections[service]
    end

    def services
      Fog::SoftLayer.services
    end

  end
end

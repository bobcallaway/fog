require 'fog/core'

module Fog
  module SoftLayer
    extend Fog::Provider

    # The base URL of the SoftLayer API's REST-like endpoints available to the public internet.
    API_PUBLIC_ENDPOINT = 'https://api.softlayer.com' unless defined? API_PUBLIC_ENDPOINT

    # The base URL of the SoftLayer API's REST-like endpoints available through SoftLayer's private network
    API_PRIVATE_ENDPOINT = 'https://api.service.softlayer.com' unless defined? API_PRIVATE_ENDPOINT

    # The base URL used for the SoftLayer API's
    $SL_API_BASE_URL = Fog::SoftLayer::API_PUBLIC_ENDPOINT

    service(:compute,        'softlayer/compute',        'Compute')

  end
end

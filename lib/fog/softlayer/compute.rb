require 'fog/softlayer'
require 'fog/softlayer/errors'
require 'fog/compute'

module Fog
  module Compute
    class SoftLayer < Fog::Service
      requires :softlayer_username
      requires :softlayer_api_key

      recognizes :softlayer_url

      model_path 'fog/softlayer/models/compute'
      request_path 'fog/softlayer/requests/compute'

      request :list_datacenters
      # request :get_datacenter

      # Keys
      collection :keys
      model :key

      request :list_keys
      request :get_key
      request :create_key
      request :delete_key

      # Images
      #collection :images
      #model :image
      #request :list_datasets
      #request :get_dataset

      # Flavors
      #collection :flavors
      #model :flavor
      #request :list_packages
      #request :get_package

      # Bare Metal Servers
      #collection :hardware_servers
      #model :hardware_server
      #request :list_hardware_servers
      #request :get_hardware_servers
      #request :create_hardware_server
      #request :start_hardware_server
      #request :stop_hardware_server
      #request :reboot_hardware_server
      #request :delete_hardware_server

      # Virtual Servers
      collection :virtual_servers
      model :virtual_server
      request :list_virtual_servers
      request :get_virtual_server
      request :get_virtual_server_power_state
      #request :create_virtual_server
      request :start_virtual_server
      request :stop_virtual_server
      request :reboot_virtual_server
      request :delete_virtual_server

      # Snapshots
      #collection :snapshots
      #model :snapshot
      #request :create_machine_snapshot
      #request :start_machine_from_snapshot
      #request :list_machine_snapshots
      #request :get_machine_snapshot
      #request :delete_machine_snapshot
      #request :update_machine_metadata
      #request :get_machine_metadata
      #request :delete_machine_metadata
      #request :delete_all_machine_metadata

      # Tags
      request :list_tags
      request :add_virtual_server_tags
      request :list_virtual_server_tags
      request :get_virtual_server_tags
      #request :delete_machine_tag
      request :delete_all_virtual_server_tags

      # Networks
      #collection :networks
      #model :network
      #request :list_networks

      class Mock
        def self.data
          @data ||= Hash.new do |hash, key|
            hash[key] = {}
          end
        end

        def data
          self.class.data
        end

        def initialize(options = {})
          @softlayer_username = options[:softlayer_username] || Fog.credentials[:softlayer_username]
          @softlayer_api_key = options[:softlayer_api_key] || Fog.credentials[:softlayer_api_key]
        end

        def request(opts)
          raise "Not Implemented"
        end
      end # Mock

      class Real
        def initialize(options = {})

          @connection_options = options[:connection_options] || {}
          @persistent = options[:persistent] || false

          @softlayer_url = options[:softlayer_url] || $SL_API_BASE_URL
          @softlayer_username = options[:softlayer_username]

          unless @softlayer_username
            raise ArgumentError, "options[:softlayer_username] required"
          end

          @softlayer_api_key = options[:softlayer_api_key]

          unless @softlayer_api_key
            raise ArgumentError, "Must provide a softlayer_api_key"
          end

          @header_method = method(:header_for_basic_auth)

          @connection = Fog::Connection.new(
            @softlayer_url,
            @persistent,
            @connection_options
          )
        end

        def request(opts = {}, skipParse = false)
          opts[:headers] = {
            "Content-Type" => "application/json",
            "Accept" => "application/json"
          }.merge(opts[:headers] || {}).merge(@header_method.call)

          if opts[:body]
            opts[:body] = Fog::JSON.encode(opts[:body])
          end

          opts[:path].insert(0,"/rest/v3/")
          
          response = @connection.request(opts)
          if response.headers["Content-Type"] == "application/json" && !skipParse
            response.body = json_decode(response.body)
          end

          response
        rescue Excon::Errors::HTTPStatusError => e
          raise_if_error!(e.request, e.response)
        end

        private

        def json_decode(body)
          parsed = Fog::JSON.decode(body)
        end

        def header_for_basic_auth
          {
            "Authorization" => "Basic #{Base64.encode64("#{@softlayer_username}:#{@softlayer_api_key}").delete("\r\n")}"
          }
        end

        def raise_if_error!(request, response)
          case response.status
          when 401 then
            raise SoftLayer::Errors::Unauthorized.new('Invalid credentials were used', request, response)
          when 403 then
            raise SoftLayer::Errors::Forbidden.new('No permissions to the specified resource', request, response)
          when 404 then
            raise SoftLayer::Errors::NotFound.new('Requested resource was not found', request, response)
          when 503 then
            raise SoftLayer::Errors::ServiceUnavailable.new('Service currently unavailable', request, response)
          end
        end

      end # Real
    end
  end
end

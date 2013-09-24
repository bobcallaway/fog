module Fog
  module Compute
    class SoftLayer < Fog::Service

      class Errors
        module MessageParserMixin
          def message
            if response.body["code"] && response.body["message"]
              "[ERROR #{response.body['code']}] : #{response.body['message']}"
            else
              ''
            end
          end

          def to_s
            message
          end
        end

        # HTTP Status Codes
        #
        # Your client should check for each of the following status codes from any API request:
        #
        # Response  Code  Description

        # 400 Bad Request Invalid HTTP Request
        class BadRequest < Excon::Errors::BadRequest
          include MessageParserMixin
        end

        # 401 Unauthorized  Either no Authorization header was sent, or invalid credentials were used
        class Unauthorized < Excon::Errors::Unauthorized
          include MessageParserMixin
        end

        # 403 Forbidden No permissions to the specified resource
        class Forbidden < Excon::Errors::Forbidden
          include MessageParserMixin
        end

        # 404 Not Found Something you requested was not found
        class NotFound < Excon::Errors::NotFound
          include MessageParserMixin
        end

        # 503 Service Unavailable Something is wrong in the cloud...
        class ServiceUnavailable < Excon::Errors::ServiceUnavailable
          include MessageParserMixin
        end
      end
    end
  end
end

